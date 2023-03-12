import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  static String? payment;

  PaymentCubit() : super(PaymentInitial());

  void setpayment(String value){
    payment = value;
    emit(PaymentInitial());

  }
}
