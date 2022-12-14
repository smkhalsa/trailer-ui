import 'package:get_it/get_it.dart';

/// Interface imports
import 'package:trailer_ui/service_interfaces/climate_service.dart';
import 'package:trailer_ui/service_interfaces/energy_service.dart';
import 'package:trailer_ui/service_interfaces/water_service.dart';
import 'package:trailer_ui/service_interfaces/linear_mechanism_service.dart';

/// Mock imports
import 'package:trailer_ui/service_mocks/mock_climate_service.dart';
import 'package:trailer_ui/service_mocks/mock_energy_service.dart';
import 'package:trailer_ui/service_mocks/mock_water_service.dart';
import 'package:trailer_ui/service_mocks/mock_mechanism_service.dart';

void setupMockServices() {
  GetIt.I.registerSingleton<ClimateService>(MockClimateService());
  GetIt.I.registerSingleton<EnergyService>(MockEnergyService());
  GetIt.I.registerSingleton<WaterService>(MockWaterService());
  GetIt.I.registerSingleton<LinearMechanismService>(
    MockLinearMechanismService(),
    instanceName: "bed",
  );
  GetIt.I.registerSingleton<LinearMechanismService>(
    MockLinearMechanismService(),
    instanceName: "awning",
  );
  GetIt.I.registerSingleton<LinearMechanismService>(
    MockLinearMechanismService(),
    instanceName: "deck",
  );
  GetIt.I.registerSingleton<LinearMechanismService>(
    MockLinearMechanismService(),
    instanceName: "leveling",
  );
}
