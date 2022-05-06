class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class FormSubmissionSuccess extends FormSubmissionStatus {}

class FormSubmissionFailed extends FormSubmissionStatus {
  final String exception;

  const FormSubmissionFailed(this.exception);
}
