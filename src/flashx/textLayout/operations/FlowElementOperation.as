////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package flashx.textLayout.operations
{
	import flashx.textLayout.debug.assert;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowGroupElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	

	
	
	/**
	 * The FlowElementOperation class is the base class for operations that transform a FlowElement.
	 *
	 * @see flashx.textLayout.formats.TextLayoutFormat
	 * @see flashx.textLayout.edit.EditManager
	 * @see flashx.textLayout.events.FlowOperationEvent
	 * 
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0 
	 */
	public class FlowElementOperation extends FlowTextOperation
	{	
		private var nestLevel:int;
		private var absStart:int;
		private var absEnd:int;
		
		private var origAbsStart:int;
		private var origAbsEnd:int;
		
		private var firstTime:Boolean = true;
		private var splitAtStart:Boolean = false;
		private var splitAtEnd:Boolean = false;
		
		private var _relStart:int = 0;
		private var _relEnd:int = -1;
		
		/** 
		 * Creates a FlowElementOperation object.
		 *  
		 * @param operationState Specifies the TextFlow object this operation acts upon.
		 * @param targetElement Specifies the element this operation modifies.
		 * @param relativeStart An offset from the beginning of the <code>targetElement</code>.
		 * @param relativeEnd An offset from the end of the <code>targetElement</code>.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function FlowElementOperation(operationState:SelectionState, targetElement:FlowElement, relativeStart:int = 0, relativeEnd:int = -1)
		{
			super(operationState);
			initialize(targetElement,relativeStart,relativeEnd);
			
			CONFIG::debug { assert(targetElement.getTextFlow() == operationState.textFlow, "ChangeElementIdOperation element is not part of selectionState TextFlow"); }
		}
		
		
		private function initialize(targetElement:FlowElement, relativeStart:int, relativeEnd:int ):void
		{
			this.targetElement = targetElement;
			this.relativeEnd = relativeEnd;
			this.relativeStart = relativeStart;
			
			if (relativeEnd == -1)
				relativeEnd = targetElement.textLength;
				
			CONFIG::debug { assert(relativeStart >= 0 && relativeStart <= targetElement.textLength,"ChangeElementIdOperation bad relativeStart"); } 
			CONFIG::debug { assert(relativeEnd >= 0 && relativeEnd <= targetElement.textLength,"ChangeElementIdOperation bad relativeEnd"); } 
			CONFIG::debug { assert(relativeStart <= relativeEnd,"ChangeElementIdOperation relativeStart not before relativeEnd"); } 

			// If we're changing the format of the text right before the terminator, change the terminator to match.
			// This will make it so that when the format change is undone, the terminator will be restored to previous state. Also
			// prevents unnecessary split & join of spans (split for apply, joined during normalize).
			if (targetElement is SpanElement && SpanElement(targetElement).hasParagraphTerminator && relativeEnd == targetElement.textLength - 1)
				relativeEnd += 1;
				
			origAbsStart = absStart = targetElement.getAbsoluteStart() + relativeStart;
			origAbsEnd   = absEnd   = absStart - relativeStart + relativeEnd;

			
		}
		
		/** 
		 * Specifies the element this operation modifies.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function get targetElement():FlowElement
		{
			var element:FlowElement = originalSelectionState.textFlow;
			for (var i:int = nestLevel; i > 0; i--)
			{
				var groupElement:FlowGroupElement = element as FlowGroupElement;
				element = groupElement.getChildAt(groupElement.findChildIndexAtPosition(absStart - element.getAbsoluteStart()));
			}
			return element;
		}
		public function set targetElement(value:FlowElement):void
		{
			nestLevel = 0;
			for (var element:FlowElement = value; element.parent != null; element = element.parent)
				++nestLevel;
		}
		
	
		/** 
		 * An offset from the beginning of the <code>targetElement</code>.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function get relativeStart():int
		{
			return _relStart;
		}
		public function set relativeStart(value:int):void
		{
			_relStart = value;
		}
		
		/** 
		 * An offset from the start of the <code>targetElement</code>.
		 * 
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
	 	 * @langversion 3.0 
		*/
		public function get relativeEnd():int
		{
			return _relEnd;
		}
		public function set relativeEnd(value:int):void
		{
			_relEnd = value;
		}
		
		
		/** @private */
		protected function getTargetElement():FlowElement
		{
			var element:FlowElement = this.targetElement;
			
			var elemStart:int = element.getAbsoluteStart();
			var splitElement:FlowElement;	// scratch
			// split at the back and then split at the start - that way paragraph terminators don't get in the way
			if (absEnd != elemStart + element.textLength)
			{
				splitElement = element.splitAtPosition(absEnd - elemStart);
				if (firstTime && splitElement != element)
					splitAtEnd = true;
			}
				
			if (absStart != elemStart)
			{
				splitElement = element.splitAtPosition(absStart-elemStart);
				if (splitElement != element)
				{
					if (firstTime)
						splitAtStart = true;
					element = splitElement;
				}
			}
			
			firstTime = false;	
			return element;
		}
		
		
		/** @private */
		protected function adjustForDoOperation(targetElement:FlowElement):void
		{
			// adjust for undo
			absStart = targetElement.getAbsoluteStart();
			absEnd   = absStart + targetElement.textLength;
		}	
		
		/** @private */
		protected function adjustForUndoOperation(targetElement:FlowElement):void
		{
			// need to do manual merging
			if ((splitAtEnd || splitAtStart) && (targetElement is FlowGroupElement))
			{
				var targetIdx:int = targetElement.parent.getChildIndex(targetElement);
				var workElem:FlowGroupElement;
				var child:FlowElement;
				
				if (splitAtEnd)
				{
					// merge next to targetElement
					workElem = targetElement.parent.getChildAt(targetIdx+1) as FlowGroupElement;
					while (workElem.numChildren)
					{
						child = workElem.getChildAt(0);
						workElem.removeChildAt(0);
						FlowGroupElement(targetElement).addChild(child);
					}
					targetElement.parent.removeChildAt(targetIdx+1);
				}
				if (splitAtStart)
				{
					// merge targetElement to prevElement
					workElem = targetElement.parent.getChildAt(targetIdx-1) as FlowGroupElement;
					while (FlowGroupElement(targetElement).numChildren)
					{
						child = FlowGroupElement(targetElement).getChildAt(0);
						FlowGroupElement(targetElement).removeChildAt(0);
						workElem.addChild(child);
					}
					targetElement.parent.removeChildAt(targetIdx);
				}
			}
			
			absStart = origAbsStart;
			absEnd   = origAbsEnd;
		}
	}
}