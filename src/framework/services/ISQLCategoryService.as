package framework.services
{
	public interface ISQLCategoryService {
		
		function updateCategory(_categoryId:uint, _columnName:String, _columnValue:*):void;
		function insertCategory(_boardId:uint, _color:uint, _title:String):void;
		function deleteCategory(_categoryId:uint):void;
		
	}
}