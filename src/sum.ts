export function sum(numbers: readonly number[]): number {
  return numbers.reduce((total, number) => total + number, 0);
}
