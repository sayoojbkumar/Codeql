import python
import semmle.python.ApiGraphs
import semmle.python.dataflow.new.DataFlow
import semmle.python.dataflow.new.TaintTracking
import semmle.python.dataflow.new.RemoteFlowSources
import semmle.python.Concepts

class SSTI extends TaintTracking::Configuration {
  SSTI() { this = "RemoteToFileConfiguration" }

  override predicate isSource(DataFlow::Node source) {
    source instanceof RemoteFlowSource
  }

  override predicate isSink(DataFlow::Node sink) {
    sink = API::moduleImport("flask").getMember("render_template_string").getACall().getArg(0)
  }
}

from DataFlow::Node input, DataFlow::Node ssti, SSTI config
where config.hasFlow(input, ssti)
select ssti, "This ssti vulnerable function uses data from ",input
