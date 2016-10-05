unit BrickCamp.Model;

interface

type
  TResourceType = (rProduct, rUser, rQuestion, rAnswer);

const
  RESOURCESTRINGS: array[TResourceType] of string = ('/product', '/user', '/question', '/answer');

  GET_GENERIC_GETONE: string = '/getone';
  GET_GENERIC_GETLIST: string = '/getlist';
  POST_GENERIC: string = '';
  PUT_GENERIC: string = '';
  DELETE_GENERIC: string = '';

  GET_USER_ONEBYNAME: string = '/getonebyname';
  GET_QUESTION_GETLISTBYPRODUCT: string = '/getlistbyproductid';
  GET_ANSWER_GETLISTBYQUESTION: string = '/getlistbyquetionid';


implementation

end.
