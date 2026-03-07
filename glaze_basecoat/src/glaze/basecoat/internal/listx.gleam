import gleam/list

pub fn append3(first: List(a), second: List(a), tercary: List(a)) -> List(a) {
  list.append(first, list.append(second, tercary))
}
