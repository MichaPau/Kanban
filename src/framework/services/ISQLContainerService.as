package framework.services
{
	import flash.utils.Dictionary;
	
	import framework.models.vo.ContainerVO;

	public interface ISQLContainerService {
		
		function createContainer(_boarderId:uint, _containerVO:ContainerVO, _containerList:Array):void;
		function deleteContainer(_containerId:uint, _updateContainerList:Array, _updateTaskList:Array):void;
		function updateContainer(_updateDict:Dictionary, _containerId:uint):void;
		
	}
}