.. _coreaction---nosessioncoreaction:

================================
CoreAction - NoSessionCoreAction
================================




Core actions availables::

    CoreView
    CoreList
    CoreUpdate
    CoreInsert
    CoreDelete
    
Parameters availables::
    
    // query parameters
    user-query // first query to run; return Map if CoreView is used or List if CoreList is used.
    user-query1-99 // other queries to run; return list1-99
    
    // result forward
    user-forward // result page
    user-actionforward // action to call after CoreAction call
    user-namespace // namespace in case the action to call with actionforward is not in the Core namespace (default: '/Core' )
    
    // paging parameters
    user-paging // query for list count
    pageScale // number of rows to display (default:50)
    pageNo // page to display (default:1)

    // common code parameters
    com-cd1-99 // common code queries; return list as cList1-99

