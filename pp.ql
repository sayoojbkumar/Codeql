
/*
from CallExpr fun1 //CalLExpr for taking deatils of function
where fun1.getCalleeName() = "require"
select fun1, "require functions"
*/

import javascript
import DataFlow::PathGraph

class Config extends TaintTracking::Configuration {
  Config() { this = "CommandLineFileNameConfiguration" }

  override predicate isSource(DataFlow::Node source) {
    DataFlow::globalVarRef("object") = source
  }

  override predicate isSink(DataFlow::Node sink) {
    DataFlow::moduleImport("flat").getAMemberCall("unflatten").getLastArgument() = sink
  }
}

from Config cfg, DataFlow::Node source, DataFlow::Node sink
where cfg.hasFlow(source, sink)
select sink, source,
  "This assignment may alter Object.prototype if a malicious '__proto__' string is injected"