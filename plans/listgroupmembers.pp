# Collects members of the given group for the specified targets and aggregates the results.
# @param targets The list of targets to report against.
# @param groupname The Windows group to pull list of members from.
plan winreports::listgroupmembers(
# This plan collects the results of members of the given group and outputs a combined report
    TargetSpec $targets,
    String $groupname,
){
    $resultset = run_task('reports::getgroupmembers', $targets, 'groupname' => $groupname)
    out::message("Hostname\t\t\t\tObject Type\tGroup Member")
    out::message("--------\t\t\t\t-----------\t------------")
    $resultset.each |$result| {
        $target  = $result.target.name
        $arr_members = parsejson($result[_output])
        $arr_members.each |$member|{
            out::message("${target}\t${member['ObjectClass']}\t\t${member['Name']}")
        }
    }
}
