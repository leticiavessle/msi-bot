declare module "bun:test" {
  type Fn = () => void | Promise<void>;
  interface It {
    (name: string, fn: Fn): void;
    each<T>(cases: readonly T[]): (name: string, fn: (c: T) => void | Promise<void>) => void;
  }
  export const it: It;
  export const test: It;
  export function describe(name: string, fn: () => void): void;
  export function expect(value: unknown): any;
}
