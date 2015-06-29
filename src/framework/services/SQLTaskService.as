package framework.services
{
	import com.probertson.data.QueuedStatement;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import framework.models.BoardModel;
	import framework.models.vo.TaskVO;
	import framework.services.helper.ISQLRunnerDelegate;
	
	
	public class SQLTaskService implements ISQLTaskService
	{
		[Inject] public var eventDispatcher:IEventDispatcher;
		[Inject] public var sqlRunner:ISQLRunnerDelegate;
		[Inject] public var boardModel:BoardModel;
		
		private var updateId:uint = 0;
		
		public function SQLTaskService()
		{
		}
		
		public function loadTaskById(id:int):void {
			sqlRunner.execute(SELECT_TASK_SQL, {taskId:id}, loadTaskResultHandler, TaskVO, onSQLErrorHandler);
		}
		
		public function updateTask(_updateDict:Dictionary, _taskId:uint):void {
			trace("SQLTaskService::updateTask");
			//var paramsObj:Object = new Object();
			
			var sqlText:String = "UPDATE main.Tasks ";
			sqlText += "SET "
				
			for (var key:String in _updateDict) {
				sqlText += key + " = :"+key + ", ";
				
			}
			sqlText = sqlText.substring(0, sqlText.length -2);
			
			sqlText += " WHERE id = :taskId";
			
			_updateDict["taskId"] = _taskId;
			
			trace(sqlText);
			
			updateId = _taskId;
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(sqlText, _updateDict);
			sqlRunner.executeModify(statements, updateTaskResultHandler, onSQLErrorHandler, null);
		}
		public function updateTask2(_columnId:String, _columnValue:*, _taskId:uint, _resultHandler:Function = null):void {
			
			var sqlText:String = "UPDATE main.Tasks ";
			sqlText += "SET " + _columnId + " = :columnValue "; 
			sqlText += "WHERE id = :taskId";
			trace(sqlText);
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(sqlText, {columnValue: _columnValue, taskId: _taskId});
			sqlRunner.executeModify(statements, _resultHandler, onSQLErrorHandler, null);
		}
		public function insertTask(_task:TaskVO):void {
			//sqlRunner
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(INSERT_TASK_SQL, {title: _task.title, containerId: _task.containerId, text: _task.text, boardId: _task.boardId, categoryId: _task.categoryId});
			sqlRunner.executeModify(statements , insertTaskResultHandler, onSQLErrorHandler, null);
		} 
		
		public function deleteTask(_taskId:uint):void {
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(DELETE_TASK_SQL, {taskId: _taskId});
			sqlRunner.executeModify(statements , deleteTaskResultHandler, onSQLErrorHandler, null);
		}
		
		/*public function updateTasksForCategory(_oldCategoryId:uint, _newCategoryId:uint):void {
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements[statements.length] = new QueuedStatement(RESET_TASKS_CATEGORY_SQL, {newCategory: _newCategoryId, oldCategory: _oldCategoryId});
			sqlRunner.executeModify(statements , resetTasksCategoryResultHandler, onSQLErrorHandler, null);
		}*/
		protected function updateTaskResultHandler(results:Vector.<SQLResult>):void {
			trace("SQLTaskService::updateTaskResultHandler");
			var result:SQLResult = results[0];
			if (result.rowsAffected > 0 && updateId != 0) {
				//var id:Number = result.lastInsertRowID;
				loadTaskById(updateId);
				updateId = 0;
			}
		}
		protected function loadTaskResultHandler(result:SQLResult):void {
			trace("SQLTaskService::loadTaskResultHandler");
			var task:TaskVO = result.data[0] as TaskVO;
			boardModel.updateTask(task);
	
		}
		
		protected function insertTaskResultHandler(results:Vector.<SQLResult>):void {
			var result:SQLResult = results[0];
			if (result.rowsAffected > 0) {
				var id:Number = result.lastInsertRowID;
				loadTaskById(id);
			}
		}
		
		protected function deleteTaskResultHandler(results:Vector.<SQLResult>):void {
			var result:SQLResult = results[0];
			
		}
		
		protected function resetTasksCategoryResultHandler(results:Vector.<SQLResult>):void {
		
		}
		protected function onSQLErrorHandler(ev:SQLError):void {
			trace("SQLService::onSQLErrorHandler");
			trace(ev.details);
			if(updateId != 0)
				updateId = 0;
		}
		
		//SQL
		[Embed(source="/assets/sql/insert/InsertTask.sql", mimeType="application/octet-stream")]
		private static const InsertTaskStatementText:Class;
		public static const INSERT_TASK_SQL:String = new InsertTaskStatementText();
		
		[Embed(source="/assets/sql/select/SelectTaskById.sql", mimeType="application/octet-stream")]
		private static const SelectTaskStatementText:Class;
		public static const SELECT_TASK_SQL:String = new SelectTaskStatementText();
		
		[Embed(source="/assets/sql/remove/DeleteTask.sql", mimeType="application/octet-stream")]
		private static const DeleteTaskStatementText:Class;
		public static const DELETE_TASK_SQL:String = new DeleteTaskStatementText();
		
		
	}
}