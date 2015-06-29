package framework.services.helper
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.filesystem.File;
	
	public class SQLRunnerDelegate implements ISQLRunnerDelegate
	{
			
		private var sqlRunner:SQLRunner;
		
		public function SQLRunnerDelegate(dataBaseFile:File, maxPoolSize:int = 5) {
			sqlRunner = new SQLRunner(dataBaseFile, maxPoolSize);
		}
		
		public function get numConnections():int {
			return sqlRunner.numConnections;
		}
		
		public function get connectionErrorHandler():Function {
			return sqlRunner.connectionErrorHandler;
		}
		
		public function set connectionErrorHandler(value:Function):void {
			sqlRunner.connectionErrorHandler = value;
		}
		
		public function execute(sql:String, parameters:Object, handler:Function, itemClass:Class = null, errorHandler:Function = null):void {
			sqlRunner.execute(sql, parameters, handler, itemClass, errorHandler);
		}
		
		public function executeModify(statementBatch:Vector.<QueuedStatement>, resultHandler:Function, errorHandler:Function, progressHandler:Function = null):void {
			sqlRunner.executeModify(statementBatch, resultHandler, errorHandler, progressHandler);
		}
		
		public function close(resultHandler:Function, errorHandler:Function = null):void {
			sqlRunner.close(resultHandler, errorHandler);
		}
	}
}