/*
* This provides the base API functionality
*/
component output="false" {

  /* 
  * This returns a new API response struct.
  */
  public struct function GetNewResponse() output="false" {
    var LOCAL = {}; // Define the local scope

    // Create a new API response
    LOCAL.Response = {
      Success = true,
      Error = '',
      Data = ''
    };

    // Return the empty response object
    return LOCAL.Response;
  }
  
}