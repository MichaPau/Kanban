package framework.services
{
	import com.probertson.data.QueuedStatement;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import framework.events.BoardEvent;
	import framework.events.UpdateBoardResultEvent;
	import framework.models.BoardModel;
	import framework.models.vo.BoardVO;
	import framework.models.vo.CategoryVO;
	import framework.models.vo.ContainerVO;
	import framework.models.vo.TaskVO;
	import framework.services.helper.ISQLRunnerDelegate;

	public class SQLService implements ISQLService 
	{
		[Inject] public var eventDispatcher:IEventDispatcher;
		[Inject] public var sqlRunner:ISQLRunnerDelegate;
		[Inject] public var boardModel:BoardModel;
		
		private var updateBoardVO:BoardVO;
		
		public function SQLService() {
			
			
		}
		
		public function loadBoards():void {
			sqlRunner.execute(SELECT_BOARDS_SQL, null, onBoardsResultHandler, BoardVO, onSQLErrorHandler);
		}
		
		public function loadCategories(_boardId:uint, reponseHandler:Function):void {
			sqlRunner.execute(SELECT_CATEGORIES_SQL, {boardId: _boardId}, reponseHandler, CategoryVO, onSQLErrorHandler);
		}
		public function loadContainers(_boardId:uint, reponseHandler:Function):void {
			sqlRunner.execute(SELECT_CONTAINERS_SQL, {boardId: _boardId}, reponseHandler, ContainerVO, onSQLErrorHandler);
		}
		public function loadTasks(_boardId:uint, reponseHandler:Function):void {
			sqlRunner.execute(SELECT_TASKS_SQL, {boardId: _boardId}, reponseHandler, TaskVO, onSQLErrorHandler);
		}
	
		
		public function insertCategory(_boardId:uint, _color:uint, _title:String):void {
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(INSERT_CATEGORY_SQL, {boardId: _boardId, color: _color, title: _title});
			sqlRunner.executeModify(statements , categoriesResultHandler, onSQLErrorHandler, null);
		}
		
		public function updateBoard(_boardVO:BoardVO):void {
			
			updateBoardVO = new BoardVO(_boardVO.id, _boardVO.title, "", 0, _boardVO.backgroundColor);
			
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(UPDATE_BOARD_SQL, {boardTitle: updateBoardVO.title, boardId: updateBoardVO.id, backgroundColor: updateBoardVO.backgroundColor});
			sqlRunner.executeModify(statements , updateBoardResultHandler, onSQLErrorHandler, null);
		}
		public function updateCategory(_categoryId:uint, _columnName:String, _columnValue:*):void {
		
			var sqlText:String = "UPDATE main.Categories ";
			sqlText += "SET " + _columnName + " = :columnParam";
			
			sqlText += " WHERE id = :categoryId";
			
			trace(sqlText);
			
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(sqlText, {categoryId: _categoryId, columnParam: _columnValue});
			sqlRunner.executeModify(statements, categoriesResultHandler, onSQLErrorHandler, null);
		}
		public function deleteCategory(_categoryId:uint):void {
			
			var defaultCatId:uint = boardModel.getDefaultCategoryId(_categoryId);
			
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(DELETE_CATEGORY_SQL, {categoryId: _categoryId});
			statements[statements.length] = new QueuedStatement(RESET_TASKS_CATEGORY_SQL, {newCategory: defaultCatId, oldCategory: _categoryId});
			sqlRunner.executeModify(statements, deleteCategoryResultHandler, onSQLErrorHandler, null);
		}
		
		public function deleteBoard(_boardId:uint):void {
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(DELETE_TASKS_FOR_BOARD_SQL, {boardId: _boardId});
			statements[statements.length] = new QueuedStatement(DELETE_CONTAINERS_FOR_BOARD_SQL, {boardId: _boardId});
			statements[statements.length] = new QueuedStatement(DELETE_CATEGORIES_FOR_BOARD_SQL, {boardId: _boardId});
			statements[statements.length] = new QueuedStatement(DELETE_BOARD_SQL, {boardId: _boardId});
			sqlRunner.executeModify(statements, deleteBoardBatchResultHandler, onSQLErrorHandler, null);
		}
		protected function onBoardsResultHandler(ev:SQLResult):void {
			var resultCollection:ArrayCollection = new ArrayCollection(ev.data);
			boardModel.boards = resultCollection;
		}
		
		protected function onSQLErrorHandler(ev:SQLError):void {
			trace("SQLService::onSQLErrorHandler");
			trace(ev.details);
		}
		
		protected function categoriesResultHandler(results:Vector.<SQLResult>):void {
			var result:SQLResult = results[0];
			if (result.rowsAffected > 0) {
				//loadCategories(boardModel.selectedBoardId);
				eventDispatcher.dispatchEvent(new BoardEvent(BoardEvent.GET_BOARD_DATA, boardModel.selectedBoardId));
			}
		}
		protected function updateBoardResultHandler(results:Vector.<SQLResult>):void {
			var result:SQLResult = results[0];
			if (result.rowsAffected > 0 && updateBoardVO) {
				boardModel.updateBoard(updateBoardVO);
				eventDispatcher.dispatchEvent(new UpdateBoardResultEvent(UpdateBoardResultEvent.RESULT, updateBoardVO));
				updateBoardVO = null;
			}
		}
		protected function deleteCategoryResultHandler(results:Vector.<SQLResult>):void {
			//reloadTasks
			
			eventDispatcher.dispatchEvent(new BoardEvent(BoardEvent.GET_BOARD_DATA, boardModel.selectedBoardId));
			
			/*var resultTasks:SQLResult = results[1];
			
			if (resultTasks.rowsAffected > 0) {
				loadTasks(boardId);
			}*/
		}
		
		protected function deleteBoardBatchResultHandler(results:Vector.<SQLResult>):void {
			boardModel.requestBoardId = 0;
			loadBoards();
		}
		//SQL
		
		[Embed(source="/assets/sql/select/SelectBoards.sql", mimeType="application/octet-stream")]
		private static const SelectBoardsStatementText:Class;
		public static const SELECT_BOARDS_SQL:String = new SelectBoardsStatementText();
		
		[Embed(source="/assets/sql/update/UpdateBoard.sql", mimeType="application/octet-stream")]
		private static const UpdateBoardStatementText:Class;
		public static const UPDATE_BOARD_SQL:String = new UpdateBoardStatementText();
		
		[Embed(source="/assets/sql/select/SelectContainers.sql", mimeType="application/octet-stream")]
		private static const SelectContainersStatementText:Class;
		public static const SELECT_CONTAINERS_SQL:String = new SelectContainersStatementText();
		
		[Embed(source="/assets/sql/select/SelectTasks.sql", mimeType="application/octet-stream")]
		private static const SelectTasksStatementText:Class;
		public static const SELECT_TASKS_SQL:String = new SelectTasksStatementText();
		
		[Embed(source="/assets/sql/select/SelectCategories.sql", mimeType="application/octet-stream")]
		private static const SelectCategoriesStatementText:Class;
		public static const SELECT_CATEGORIES_SQL:String = new SelectCategoriesStatementText();
		
		[Embed(source="/assets/sql/insert/InsertCategory.sql", mimeType="application/octet-stream")]
		private static const InsertCategoryStatementText:Class;
		public static const INSERT_CATEGORY_SQL:String = new InsertCategoryStatementText();
		
		[Embed(source="/assets/sql/remove/DeleteCategory.sql", mimeType="application/octet-stream")]
		private static const DeleteCategoryStatementText:Class;
		public static const DELETE_CATEGORY_SQL:String = new DeleteCategoryStatementText();
		
		[Embed(source="/assets/sql/update/ResetTasksCategory.sql", mimeType="application/octet-stream")]
		private static const ResetTasksCategoryStatementText:Class;
		public static const RESET_TASKS_CATEGORY_SQL:String = new ResetTasksCategoryStatementText();
		
		[Embed(source="/assets/sql/remove/DeleteBoard.sql", mimeType="application/octet-stream")]
		private static const DeleteBoardStatementText:Class;
		public static const DELETE_BOARD_SQL:String = new DeleteBoardStatementText();
		
		[Embed(source="/assets/sql/remove/DeleteTasksForBoard.sql", mimeType="application/octet-stream")]
		private static const DeleteTasksForBoardStatementText:Class;
		public static const DELETE_TASKS_FOR_BOARD_SQL:String = new DeleteTasksForBoardStatementText();
		
		[Embed(source="/assets/sql/remove/DeleteContainersForBoard.sql", mimeType="application/octet-stream")]
		private static const DeleteContainersForBoardStatementText:Class;
		public static const DELETE_CONTAINERS_FOR_BOARD_SQL:String = new DeleteContainersForBoardStatementText();
		
		[Embed(source="/assets/sql/remove/DeleteCategoriesForBoard.sql", mimeType="application/octet-stream")]
		private static const DeleteCategoriesForBoardStatementText:Class;
		public static const DELETE_CATEGORIES_FOR_BOARD_SQL:String = new DeleteCategoriesForBoardStatementText();
	}
}