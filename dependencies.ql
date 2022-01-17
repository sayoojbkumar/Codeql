import javascript

from NPMPackage pkg, PackageDependencies deps,BugTrackerInfo bugs
where deps.getADependency("flat", "5.0.0") or bugs=pkg.getPackageJSON().getBugs()
select deps,bugs