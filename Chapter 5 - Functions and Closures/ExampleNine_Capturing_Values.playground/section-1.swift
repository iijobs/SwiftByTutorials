typealias StateMachineType = () -> Int

func makeStateMachine(maxState: Int) -> StateMachineType {
  var currentState: Int = 0
  return {
    currentState++
    if currentState > maxState {
      currentState = 0
    }
    return currentState
  }
}

let tristate = makeStateMachine(2)
// currentState variable is destroyed?!
println(tristate())
println(tristate())
println(tristate())
println(tristate())
println(tristate())

let bistate = makeStateMachine(1)
println(bistate());
println(bistate());
println(bistate());
println(bistate());