package
{
   import fl.controls.listClasses.CellRenderer;
   
   public class CustomCellRenderer extends CellRenderer
   {
      public function CustomCellRenderer()
      {
         super();
         setStyle("embedFonts",true);
         setStyle("textFormat",Constants.TEXT_FORMAT_BLACK_BOTTOM);
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         textField.x -= 5;
      }
   }
}

