package framework.services
{
	import framework.models.vo.BoardVO;

	public interface ISQLService {
		
		function loadBoards():void;
		function updateBoard(_boardVO:BoardVO):void;
		
		function loadCategories(_boardId:uint, reponseHandler:Function):void;
		function loadContainers(_boardId:uint, reponseHandler:Function):void;
		function loadTasks(_boardId:uint, reponseHandler:Function):void;
		
		function insertCategory(_boardId:uint, _color:uint, _title:String):void;
		function updateCategory(_categoryId:uint, _columnName:String, _columnValue:*):void;
		function deleteCategory(_categoryId:uint):void;
		
		function deleteBoard(_boardId:uint):void;
		
		
	}
}