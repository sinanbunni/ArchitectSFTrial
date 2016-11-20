public with sharing class AbstractFactory {
	
	interface IProcessor {
		void performaceOperation();
	}

	interface IStorage {
		void storeData();
	}

	interface IMonitor {
		void display();
	}

	class LEDMonitor implements IMonitor {
		public void display() {
			System.debug('Monitor is LED monitor');
		}
	}

	class LCDMonitor implements IMonitor {
		public void display() {
			System.debug('Monitor is LCD monitor');
		}
	}

	class SSDStorage implements IStorage {
		public void storeData() {
			System.debug('Storage is a SSD storage');
		}
	}

	class HDDStorage implements IStorage {
		public void storeData() {
			System.debug('Storage is a HDD storage');
		}
	}

	class QuadCore implements IProcessor {
		public void performaceOperation() {
			System.debug('Process is a QuadCore processor');
		}
	}

	class DualCore implements IProcessor {
		public void performaceOperation() {
			System.debug('Processor is a DualCore processor');
		}
	}

	public interface IComputerFactory {
		IProcessor getProcessor();
		IStorage getStorage();
		IMonitor getMonitor();
	}

	public class HighPerformance implements IComputerFactory {
		public IProcessor getProcessor() {
			return new QuadCore();
		}

		public IStorage getStorage() {
			return new HDDStorage();
		}

		public IMonitor getMonitor() {
			return new LCDMonitor();
		}
	}

	public class StandardPerformance implements IComputerFactory {
		public IProcessor getProcessor() {
			return new DualCore();
		}

		public IStorage getStorage() {
			return new SSDStorage();
		}

		public IMonitor getMonitor() {
			return new LEDMonitor();
		}
	}

	public class AssembleComputer {
		IComputerFactory computer;

		public AssembleComputer (IComputerFactory computer) {
			this.computer = computer;
		}

		public void testCompleteSystem() {
			IProcessor processor = computer.getProcessor();
			IStorage storage = computer.getStorage();
			IMonitor monitor = computer.getMonitor();

			processor.performaceOperation();
			storage.storeData();
			monitor.display();
		}
	}

} // end AbstractFactory class