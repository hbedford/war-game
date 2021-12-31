//Result LR tem como objetivo retornar um dos 2 tipos

// Como adicionar como retorno de uma função
// ResultLR<T,T> func()=>Left(valor);

// como receber de uma função
// ResultLR<T,T> result = func();

// como verificar se o valor é o primeiro Tipo
// result.isLeft

// como pegar o resultado caso seja do primeiro Tipo
// (result as Left).value

abstract class ResultLR<Left, Right> {
  const ResultLR();
  B fold<B>(B ifLeft(Left l), B ifRight(Right r));
  bool isLeft() => fold((_) => true, (_) => false);
  bool isRight() => fold((_) => false, (_) => true);
}

class Left<L, R> extends ResultLR<L, R> {
  final L _l;
  const Left(this._l);
  L get value => _l;
  @override
  B fold<B>(B ifLeft(L l), B ifRight(R r)) => ifLeft(_l);
  @override
  bool operator ==(other) => other is Left && other._l == _l;
  @override
  int get hashCode => _l.hashCode;
}

class Right<L, R> extends ResultLR<L, R> {
  final R _r;
  const Right(this._r);
  R get value => _r;
  @override
  B fold<B>(B ifLeft(L l), B ifRight(R r)) => ifRight(_r);
  @override
  bool operator ==(other) => other is Right && other._r == _r;
  @override
  int get hashCode => _r.hashCode;
}
