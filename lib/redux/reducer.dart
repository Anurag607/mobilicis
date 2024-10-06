import 'actions.dart';
import 'states/filter_state.dart';

SelectedFitlersState selectedFiltersReducer(
    SelectedFitlersState state, dynamic action) {
  if (action is UpdateSelectedFiltersAction) {
    return SelectedFitlersState(selectedFilters: action.selectedFilters);
  }
  return state;
}
