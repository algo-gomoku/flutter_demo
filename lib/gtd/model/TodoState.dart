enum TodoState { DONE, DELAY, CLOCKING, TODO }

TodoState getStateFromString(state) {
  switch (state) {
    case "DONE":
      return TodoState.DONE;
    case "TODO":
      return TodoState.TODO;
    case "DELAY":
      return TodoState.DELAY;
    case "CLOCKING":
      return TodoState.CLOCKING;
    default:
      return TodoState.TODO;
  }
}