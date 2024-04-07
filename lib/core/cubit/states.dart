
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppHomeGetDataLoadingState extends AppStates {}
class IsSwitchedState extends AppStates {}
class AppCreateDatabaseState extends AppStates {}
class AppGetDatabaseLoadingState extends AppStates {}
class AppGetDatabaseState extends AppStates {}
class AppUpdateDatabaseState extends AppStates {}
class AppDeleteDatabaseState extends AppStates {}
class AppInsertDatabaseState extends AppStates {}
class emitNoThink extends AppStates {}

