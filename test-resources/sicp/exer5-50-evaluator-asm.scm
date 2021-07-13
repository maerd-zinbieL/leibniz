(assign val (op make-compiled-procedure) (label entry1112) (reg env))
(goto (label after-lambda1111))
entry1112
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (env)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1115))
compiled-branch1114
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1115
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1113
after-lambda1111
(perform (op define-variable!) (const enclosing-environment) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry1107) (reg env))
(goto (label after-lambda1106))
entry1107
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (env)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1110))
compiled-branch1109
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1110
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1108
after-lambda1106
(perform (op define-variable!) (const first-frame) (reg val) (reg env))
(assign val (const ok))
(assign val (const ()))
(perform (op define-variable!) (const the-empty-environment) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry1102) (reg env))
(goto (label after-lambda1101))
entry1102
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (variables values)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cons) (reg env))
(assign val (op lookup-variable-value) (const values) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const variables) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1105))
compiled-branch1104
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1105
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1103
after-lambda1101
(perform (op define-variable!) (const make-frame) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry1097) (reg env))
(goto (label after-lambda1096))
entry1097
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1100))
compiled-branch1099
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1100
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1098
after-lambda1096
(perform (op define-variable!) (const frame-variables) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry1092) (reg env))
(goto (label after-lambda1091))
entry1092
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1095))
compiled-branch1094
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1095
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1093
after-lambda1091
(perform (op define-variable!) (const frame-values) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry1072) (reg env))
(goto (label after-lambda1071))
entry1072
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (var val frame)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const set-car!) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cons) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1084))
compiled-branch1083
(assign continue (label after-call1082))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1084
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1082
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const var) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1087))
compiled-branch1086
(assign continue (label after-call1085))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1087
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1085
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1090))
compiled-branch1089
(assign continue (label after-call1088))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1090
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1088
(restore env)
(restore continue)
(assign proc (op lookup-variable-value) (const set-cdr!) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cons) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1075))
compiled-branch1074
(assign continue (label after-call1073))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1075
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1073
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const val) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1078))
compiled-branch1077
(assign continue (label after-call1076))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1078
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1076
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1081))
compiled-branch1080
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1081
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1079
after-lambda1071
(perform (op define-variable!) (const add-binding-to-frame!) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry1034) (reg env))
(goto (label after-lambda1033))
entry1034
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (vars vals base-env)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const =) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const length) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1067))
compiled-branch1066
(assign continue (label after-call1065))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1067
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1065
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const length) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1064))
compiled-branch1063
(assign continue (label after-call1062))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1064
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1062
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1070))
compiled-branch1069
(assign continue (label after-call1068))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1070
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1068
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch1036))
true-branch1037
(assign proc (op lookup-variable-value) (const cons) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const base-env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const make-frame) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1058))
compiled-branch1057
(assign continue (label after-call1056))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1058
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1056
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1061))
compiled-branch1060
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1061
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1059
false-branch1036
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const <) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const length) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1052))
compiled-branch1051
(assign continue (label after-call1050))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1052
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1050
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const length) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1049))
compiled-branch1048
(assign continue (label after-call1047))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1049
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1047
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1055))
compiled-branch1054
(assign continue (label after-call1053))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1055
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1053
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch1039))
true-branch1040
(assign proc (op lookup-variable-value) (const error) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (const "Too many arguments supplied"))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1046))
compiled-branch1045
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1046
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1044
false-branch1039
(assign proc (op lookup-variable-value) (const error) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (const "Too few arguments supplied"))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1043))
compiled-branch1042
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1043
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1041
after-if1038
after-if1035
after-lambda1033
(perform (op define-variable!) (const extend-environment) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry966) (reg env))
(goto (label after-lambda965))
entry966
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (var env)) (reg argl) (reg env))
(assign val (op make-compiled-procedure) (label entry971) (reg env))
(goto (label after-lambda970))
entry971
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (env)) (reg argl) (reg env))
(assign val (op make-compiled-procedure) (label entry999) (reg env))
(goto (label after-lambda998))
entry999
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (vars vals)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1032))
compiled-branch1031
(assign continue (label after-call1030))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1032
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1030
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch1001))
true-branch1002
(assign proc (op lookup-variable-value) (const env-loop) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const enclosing-environment) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1026))
compiled-branch1025
(assign continue (label after-call1024))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1026
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1024
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1029))
compiled-branch1028
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1029
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1027
false-branch1001
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1020))
compiled-branch1019
(assign continue (label after-call1018))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1020
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1018
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const var) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1023))
compiled-branch1022
(assign continue (label after-call1021))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1023
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1021
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch1004))
true-branch1005
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1017))
compiled-branch1016
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1017
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1015
false-branch1004
(assign proc (op lookup-variable-value) (const scan) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1011))
compiled-branch1010
(assign continue (label after-call1009))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1011
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1009
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1008))
compiled-branch1007
(assign continue (label after-call1006))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1008
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1006
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch1014))
compiled-branch1013
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch1014
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call1012
after-if1003
after-if1000
after-lambda998
(perform (op define-variable!) (const scan) (reg val) (reg env))
(assign val (const ok))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(assign val (op lookup-variable-value) (const the-empty-environment) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch997))
compiled-branch996
(assign continue (label after-call995))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch997
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call995
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch973))
true-branch974
(assign proc (op lookup-variable-value) (const error) (reg env))
(assign val (op lookup-variable-value) (const var) (reg env))
(assign argl (op list) (reg val))
(assign val (const "Unbound variable"))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch994))
compiled-branch993
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch994
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call992
false-branch973
(assign proc (op make-compiled-procedure) (label entry979) (reg env))
(goto (label after-lambda978))
entry979
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const scan) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const frame-values) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch985))
compiled-branch984
(assign continue (label after-call983))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch985
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call983
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const frame-variables) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch982))
compiled-branch981
(assign continue (label after-call980))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch982
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call980
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch988))
compiled-branch987
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch988
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call986
after-lambda978
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const first-frame) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch977))
compiled-branch976
(assign continue (label after-call975))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch977
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call975
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch991))
compiled-branch990
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch991
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call989
after-if972
after-lambda970
(perform (op define-variable!) (const env-loop) (reg val) (reg env))
(assign val (const ok))
(assign proc (op lookup-variable-value) (const env-loop) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch969))
compiled-branch968
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch969
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call967
after-lambda965
(perform (op define-variable!) (const lookup-variable-value) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry898) (reg env))
(goto (label after-lambda897))
entry898
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (var val env)) (reg argl) (reg env))
(assign val (op make-compiled-procedure) (label entry903) (reg env))
(goto (label after-lambda902))
entry903
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (env)) (reg argl) (reg env))
(assign val (op make-compiled-procedure) (label entry931) (reg env))
(goto (label after-lambda930))
entry931
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (vars vals)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch964))
compiled-branch963
(assign continue (label after-call962))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch964
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call962
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch933))
true-branch934
(assign proc (op lookup-variable-value) (const env-loop) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const enclosing-environment) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch958))
compiled-branch957
(assign continue (label after-call956))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch958
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call956
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch961))
compiled-branch960
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch961
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call959
false-branch933
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch952))
compiled-branch951
(assign continue (label after-call950))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch952
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call950
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const var) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch955))
compiled-branch954
(assign continue (label after-call953))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch955
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call953
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch936))
true-branch937
(assign proc (op lookup-variable-value) (const set-car!) (reg env))
(assign val (op lookup-variable-value) (const val) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch949))
compiled-branch948
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch949
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call947
false-branch936
(assign proc (op lookup-variable-value) (const scan) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch943))
compiled-branch942
(assign continue (label after-call941))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch943
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call941
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch940))
compiled-branch939
(assign continue (label after-call938))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch940
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call938
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch946))
compiled-branch945
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch946
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call944
after-if935
after-if932
after-lambda930
(perform (op define-variable!) (const scan) (reg val) (reg env))
(assign val (const ok))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(assign val (op lookup-variable-value) (const the-empty-environment) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch929))
compiled-branch928
(assign continue (label after-call927))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch929
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call927
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch905))
true-branch906
(assign proc (op lookup-variable-value) (const error) (reg env))
(assign val (op lookup-variable-value) (const var) (reg env))
(assign argl (op list) (reg val))
(assign val (const "Unbound variable: SET!"))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch926))
compiled-branch925
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch926
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call924
false-branch905
(assign proc (op make-compiled-procedure) (label entry911) (reg env))
(goto (label after-lambda910))
entry911
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const scan) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const frame-values) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch917))
compiled-branch916
(assign continue (label after-call915))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch917
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call915
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const frame-variables) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch914))
compiled-branch913
(assign continue (label after-call912))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch914
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call912
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch920))
compiled-branch919
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch920
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call918
after-lambda910
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const first-frame) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch909))
compiled-branch908
(assign continue (label after-call907))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch909
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call907
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch923))
compiled-branch922
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch923
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call921
after-if904
after-lambda902
(perform (op define-variable!) (const env-loop) (reg val) (reg env))
(assign val (const ok))
(assign proc (op lookup-variable-value) (const env-loop) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch901))
compiled-branch900
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch901
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call899
after-lambda897
(perform (op define-variable!) (const set-variable-value!) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry847) (reg env))
(goto (label after-lambda846))
entry847
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (var val env)) (reg argl) (reg env))
(assign proc (op make-compiled-procedure) (label entry852) (reg env))
(goto (label after-lambda851))
entry852
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
(assign val (op make-compiled-procedure) (label entry863) (reg env))
(goto (label after-lambda862))
entry863
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (vars vals)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch893))
compiled-branch892
(assign continue (label after-call891))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch893
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call891
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch865))
true-branch866
(assign proc (op lookup-variable-value) (const add-binding-to-frame!) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const val) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (op lookup-variable-value) (const var) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch890))
compiled-branch889
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch890
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call888
false-branch865
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch884))
compiled-branch883
(assign continue (label after-call882))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch884
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call882
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const var) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch887))
compiled-branch886
(assign continue (label after-call885))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch887
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call885
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch868))
true-branch869
(assign proc (op lookup-variable-value) (const set-car!) (reg env))
(assign val (op lookup-variable-value) (const val) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch881))
compiled-branch880
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch881
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call879
false-branch868
(assign proc (op lookup-variable-value) (const scan) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const vals) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch875))
compiled-branch874
(assign continue (label after-call873))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch875
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call873
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const vars) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch872))
compiled-branch871
(assign continue (label after-call870))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch872
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call870
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch878))
compiled-branch877
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch878
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call876
after-if867
after-if864
after-lambda862
(perform (op define-variable!) (const scan) (reg val) (reg env))
(assign val (const ok))
(assign proc (op lookup-variable-value) (const scan) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const frame-values) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch858))
compiled-branch857
(assign continue (label after-call856))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch858
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call856
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const frame-variables) (reg env))
(assign val (op lookup-variable-value) (const frame) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch855))
compiled-branch854
(assign continue (label after-call853))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch855
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call853
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch861))
compiled-branch860
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch861
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call859
after-lambda851
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const first-frame) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch850))
compiled-branch849
(assign continue (label after-call848))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch850
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call848
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch896))
compiled-branch895
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch896
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call894
after-lambda846
(perform (op define-variable!) (const define-variable!) (reg val) (reg env))
(assign val (const ok))
(assign val (op lookup-variable-value) (const apply) (reg env))
(perform (op define-variable!) (const apply-in-underlying-scheme) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry833) (reg env))
(goto (label after-lambda832))
entry833
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp tag)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const pair?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch845))
compiled-branch844
(assign continue (label after-call843))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch845
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call843
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch835))
true-branch836
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const tag) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch839))
compiled-branch838
(assign continue (label after-call837))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch839
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call837
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch842))
compiled-branch841
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch842
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call840
false-branch835
(assign val (op lookup-variable-value) (const false) (reg env))
(goto (reg continue))
after-if834
after-lambda832
(perform (op define-variable!) (const tagged-list?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry819) (reg env))
(goto (label after-lambda818))
entry819
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const number?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch831))
compiled-branch830
(assign continue (label after-call829))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch831
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call829
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch821))
true-branch822
(assign val (op lookup-variable-value) (const true) (reg env))
(goto (reg continue))
false-branch821
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const string?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch828))
compiled-branch827
(assign continue (label after-call826))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch828
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call826
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch824))
true-branch825
(assign val (op lookup-variable-value) (const true) (reg env))
(goto (reg continue))
false-branch824
(assign val (op lookup-variable-value) (const false) (reg env))
(goto (reg continue))
after-if823
after-if820
after-lambda818
(perform (op define-variable!) (const self-evaluating?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry814) (reg env))
(goto (label after-lambda813))
entry814
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const symbol?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch817))
compiled-branch816
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch817
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call815
after-lambda813
(perform (op define-variable!) (const variable?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry809) (reg env))
(goto (label after-lambda808))
entry809
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const quote))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch812))
compiled-branch811
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch812
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call810
after-lambda808
(perform (op define-variable!) (const quoted?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry804) (reg env))
(goto (label after-lambda803))
entry804
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch807))
compiled-branch806
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch807
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call805
after-lambda803
(perform (op define-variable!) (const text-of-quotation) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry799) (reg env))
(goto (label after-lambda798))
entry799
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const set!))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch802))
compiled-branch801
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch802
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call800
after-lambda798
(perform (op define-variable!) (const assignment?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry794) (reg env))
(goto (label after-lambda793))
entry794
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch797))
compiled-branch796
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch797
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call795
after-lambda793
(perform (op define-variable!) (const assignment-variable) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry789) (reg env))
(goto (label after-lambda788))
entry789
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const caddr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch792))
compiled-branch791
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch792
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call790
after-lambda788
(perform (op define-variable!) (const assignment-value) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry775) (reg env))
(goto (label after-lambda774))
entry775
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
(save continue)
(assign proc (op lookup-variable-value) (const set-variable-value!) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const assignment-value) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch781))
compiled-branch780
(assign continue (label after-call779))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch781
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call779
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch784))
compiled-branch783
(assign continue (label after-call782))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch784
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call782
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const assignment-variable) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch778))
compiled-branch777
(assign continue (label after-call776))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch778
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call776
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch787))
compiled-branch786
(assign continue (label after-call785))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch787
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call785
(restore continue)
(assign val (const "<assignment return>"))
(goto (reg continue))
after-lambda774
(perform (op define-variable!) (const eval-assignment) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry770) (reg env))
(goto (label after-lambda769))
entry770
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const define))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch773))
compiled-branch772
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch773
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call771
after-lambda769
(perform (op define-variable!) (const definition?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry753) (reg env))
(goto (label after-lambda752))
entry753
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const symbol?) (reg env))
(save proc)
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch765))
compiled-branch764
(assign continue (label after-call763))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch765
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call763
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch768))
compiled-branch767
(assign continue (label after-call766))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch768
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call766
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch755))
true-branch756
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch762))
compiled-branch761
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch762
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call760
false-branch755
(assign proc (op lookup-variable-value) (const caadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch759))
compiled-branch758
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch759
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call757
after-if754
after-lambda752
(perform (op define-variable!) (const definition-variable) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry730) (reg env))
(goto (label after-lambda729))
entry730
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const symbol?) (reg env))
(save proc)
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch748))
compiled-branch747
(assign continue (label after-call746))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch748
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call746
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch751))
compiled-branch750
(assign continue (label after-call749))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch751
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call749
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch732))
true-branch733
(assign proc (op lookup-variable-value) (const caddr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch745))
compiled-branch744
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch745
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call743
false-branch732
(assign proc (op lookup-variable-value) (const make-lambda) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cddr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch739))
compiled-branch738
(assign continue (label after-call737))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch739
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call737
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const cdadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch736))
compiled-branch735
(assign continue (label after-call734))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch736
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call734
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch742))
compiled-branch741
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch742
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call740
after-if731
after-lambda729
(perform (op define-variable!) (const definition-value) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry716) (reg env))
(goto (label after-lambda715))
entry716
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
(save continue)
(assign proc (op lookup-variable-value) (const define-variable!) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const definition-value) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch722))
compiled-branch721
(assign continue (label after-call720))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch722
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call720
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch725))
compiled-branch724
(assign continue (label after-call723))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch725
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call723
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const definition-variable) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch719))
compiled-branch718
(assign continue (label after-call717))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch719
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call717
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch728))
compiled-branch727
(assign continue (label after-call726))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch728
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call726
(restore continue)
(assign val (const "<definition return>"))
(goto (reg continue))
after-lambda715
(perform (op define-variable!) (const eval-definition) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry711) (reg env))
(goto (label after-lambda710))
entry711
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const lambda))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch714))
compiled-branch713
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch714
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call712
after-lambda710
(perform (op define-variable!) (const lambda?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry706) (reg env))
(goto (label after-lambda705))
entry706
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch709))
compiled-branch708
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch709
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call707
after-lambda705
(perform (op define-variable!) (const lambda-parameters) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry701) (reg env))
(goto (label after-lambda700))
entry701
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cddr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch704))
compiled-branch703
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch704
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call702
after-lambda700
(perform (op define-variable!) (const lambda-body) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry693) (reg env))
(goto (label after-lambda692))
entry693
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (parameters body)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cons) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const cons) (reg env))
(assign val (op lookup-variable-value) (const body) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const parameters) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch696))
compiled-branch695
(assign continue (label after-call694))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch696
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call694
(assign argl (op list) (reg val))
(assign val (const lambda))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch699))
compiled-branch698
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch699
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call697
after-lambda692
(perform (op define-variable!) (const make-lambda) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry688) (reg env))
(goto (label after-lambda687))
entry688
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const if))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch691))
compiled-branch690
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch691
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call689
after-lambda687
(perform (op define-variable!) (const if?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry683) (reg env))
(goto (label after-lambda682))
entry683
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch686))
compiled-branch685
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch686
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call684
after-lambda682
(perform (op define-variable!) (const if-predicate) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry678) (reg env))
(goto (label after-lambda677))
entry678
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const caddr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch681))
compiled-branch680
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch681
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call679
after-lambda677
(perform (op define-variable!) (const if-consequent) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry661) (reg env))
(goto (label after-lambda660))
entry661
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const not) (reg env))
(save proc)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(save proc)
(assign proc (op lookup-variable-value) (const cdddr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch670))
compiled-branch669
(assign continue (label after-call668))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch670
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call668
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch673))
compiled-branch672
(assign continue (label after-call671))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch673
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call671
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch676))
compiled-branch675
(assign continue (label after-call674))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch676
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call674
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch663))
true-branch664
(assign proc (op lookup-variable-value) (const cadddr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch667))
compiled-branch666
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch667
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call665
false-branch663
(assign val (const false))
(goto (reg continue))
after-if662
after-lambda660
(perform (op define-variable!) (const if-alternative) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry656) (reg env))
(goto (label after-lambda655))
entry656
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (predicate consequent alternative)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const alternative) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const consequent) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (op lookup-variable-value) (const predicate) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (const if))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch659))
compiled-branch658
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch659
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call657
after-lambda655
(perform (op define-variable!) (const make-if) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry630) (reg env))
(goto (label after-lambda629))
entry630
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const true?) (reg env))
(save proc)
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const if-predicate) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch648))
compiled-branch647
(assign continue (label after-call646))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch648
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call646
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch651))
compiled-branch650
(assign continue (label after-call649))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch651
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call649
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch654))
compiled-branch653
(assign continue (label after-call652))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch654
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call652
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch632))
true-branch633
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const if-consequent) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch642))
compiled-branch641
(assign continue (label after-call640))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch642
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call640
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch645))
compiled-branch644
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch645
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call643
false-branch632
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const if-alternative) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch636))
compiled-branch635
(assign continue (label after-call634))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch636
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call634
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch639))
compiled-branch638
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch639
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call637
after-if631
after-lambda629
(perform (op define-variable!) (const eval-if) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry625) (reg env))
(goto (label after-lambda624))
entry625
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const begin))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch628))
compiled-branch627
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch628
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call626
after-lambda624
(perform (op define-variable!) (const begin?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry620) (reg env))
(goto (label after-lambda619))
entry620
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch623))
compiled-branch622
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch623
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call621
after-lambda619
(perform (op define-variable!) (const begin-actions) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry612) (reg env))
(goto (label after-lambda611))
entry612
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (seq)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const null?) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch615))
compiled-branch614
(assign continue (label after-call613))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch615
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call613
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch618))
compiled-branch617
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch618
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call616
after-lambda611
(perform (op define-variable!) (const last-exp?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry607) (reg env))
(goto (label after-lambda606))
entry607
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (seq)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch610))
compiled-branch609
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch610
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call608
after-lambda606
(perform (op define-variable!) (const first-exp) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry602) (reg env))
(goto (label after-lambda601))
entry602
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (seq)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch605))
compiled-branch604
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch605
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call603
after-lambda601
(perform (op define-variable!) (const rest-exps) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry582) (reg env))
(goto (label after-lambda581))
entry582
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (seq)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch600))
compiled-branch599
(assign continue (label after-call598))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch600
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call598
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch584))
true-branch585
(assign val (op lookup-variable-value) (const seq) (reg env))
(goto (reg continue))
false-branch584
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const last-exp?) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch597))
compiled-branch596
(assign continue (label after-call595))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch597
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call595
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch587))
true-branch588
(assign proc (op lookup-variable-value) (const first-exp) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch594))
compiled-branch593
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch594
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call592
false-branch587
(assign proc (op lookup-variable-value) (const make-begin) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch591))
compiled-branch590
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch591
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call589
after-if586
after-if583
after-lambda581
(perform (op define-variable!) (const sequence->exp) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry577) (reg env))
(goto (label after-lambda576))
entry577
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (seq)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cons) (reg env))
(assign val (op lookup-variable-value) (const seq) (reg env))
(assign argl (op list) (reg val))
(assign val (const begin))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch580))
compiled-branch579
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch580
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call578
after-lambda576
(perform (op define-variable!) (const make-begin) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry551) (reg env))
(goto (label after-lambda550))
entry551
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exps env)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const last-exp?) (reg env))
(assign val (op lookup-variable-value) (const exps) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch575))
compiled-branch574
(assign continue (label after-call573))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch575
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call573
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch553))
true-branch554
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const first-exp) (reg env))
(assign val (op lookup-variable-value) (const exps) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch569))
compiled-branch568
(assign continue (label after-call567))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch569
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call567
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch572))
compiled-branch571
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch572
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call570
false-branch553
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const first-exp) (reg env))
(assign val (op lookup-variable-value) (const exps) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch563))
compiled-branch562
(assign continue (label after-call561))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch563
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call561
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch566))
compiled-branch565
(assign continue (label after-call564))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch566
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call564
(restore env)
(restore continue)
(assign proc (op lookup-variable-value) (const eval-sequence) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const rest-exps) (reg env))
(assign val (op lookup-variable-value) (const exps) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch557))
compiled-branch556
(assign continue (label after-call555))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch557
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call555
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch560))
compiled-branch559
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch560
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call558
after-if552
after-lambda550
(perform (op define-variable!) (const eval-sequence) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry546) (reg env))
(goto (label after-lambda545))
entry546
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const pair?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch549))
compiled-branch548
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch549
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call547
after-lambda545
(perform (op define-variable!) (const application?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry541) (reg env))
(goto (label after-lambda540))
entry541
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch544))
compiled-branch543
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch544
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call542
after-lambda540
(perform (op define-variable!) (const operator) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry536) (reg env))
(goto (label after-lambda535))
entry536
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch539))
compiled-branch538
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch539
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call537
after-lambda535
(perform (op define-variable!) (const operands) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry531) (reg env))
(goto (label after-lambda530))
entry531
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (ops)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const ops) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch534))
compiled-branch533
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch534
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call532
after-lambda530
(perform (op define-variable!) (const no-operands?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry526) (reg env))
(goto (label after-lambda525))
entry526
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (ops)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const ops) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch529))
compiled-branch528
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch529
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call527
after-lambda525
(perform (op define-variable!) (const first-operand) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry521) (reg env))
(goto (label after-lambda520))
entry521
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (ops)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const ops) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch524))
compiled-branch523
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch524
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call522
after-lambda520
(perform (op define-variable!) (const rest-operands) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry498) (reg env))
(goto (label after-lambda497))
entry498
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exps env)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const no-operands?) (reg env))
(assign val (op lookup-variable-value) (const exps) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch519))
compiled-branch518
(assign continue (label after-call517))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch519
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call517
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch500))
true-branch501
(assign val (const ()))
(goto (reg continue))
false-branch500
(assign proc (op lookup-variable-value) (const cons) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const list-of-values) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const rest-operands) (reg env))
(assign val (op lookup-variable-value) (const exps) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch510))
compiled-branch509
(assign continue (label after-call508))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch510
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call508
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch513))
compiled-branch512
(assign continue (label after-call511))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch513
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call511
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const first-operand) (reg env))
(assign val (op lookup-variable-value) (const exps) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch504))
compiled-branch503
(assign continue (label after-call502))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch504
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call502
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch507))
compiled-branch506
(assign continue (label after-call505))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch507
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call505
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch516))
compiled-branch515
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch516
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call514
after-if499
after-lambda497
(perform (op define-variable!) (const list-of-values) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry490) (reg env))
(goto (label after-lambda489))
entry490
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (x)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const not) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(assign val (op lookup-variable-value) (const false) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const x) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch493))
compiled-branch492
(assign continue (label after-call491))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch493
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call491
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch496))
compiled-branch495
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch496
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call494
after-lambda489
(perform (op define-variable!) (const true?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry485) (reg env))
(goto (label after-lambda484))
entry485
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (x)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(assign val (op lookup-variable-value) (const false) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const x) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch488))
compiled-branch487
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch488
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call486
after-lambda484
(perform (op define-variable!) (const false?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry480) (reg env))
(goto (label after-lambda479))
entry480
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (parameters body env)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const body) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (op lookup-variable-value) (const parameters) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (const procedure))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch483))
compiled-branch482
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch483
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call481
after-lambda479
(perform (op define-variable!) (const make-procedure) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry475) (reg env))
(goto (label after-lambda474))
entry475
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (p)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const procedure))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const p) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch478))
compiled-branch477
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch478
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call476
after-lambda474
(perform (op define-variable!) (const compound-procedure?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry470) (reg env))
(goto (label after-lambda469))
entry470
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (p)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const p) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch473))
compiled-branch472
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch473
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call471
after-lambda469
(perform (op define-variable!) (const procedure-parameters) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry465) (reg env))
(goto (label after-lambda464))
entry465
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (p)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const caddr) (reg env))
(assign val (op lookup-variable-value) (const p) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch468))
compiled-branch467
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch468
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call466
after-lambda464
(perform (op define-variable!) (const procedure-body) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry460) (reg env))
(goto (label after-lambda459))
entry460
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (p)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cadddr) (reg env))
(assign val (op lookup-variable-value) (const p) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch463))
compiled-branch462
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch463
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call461
after-lambda459
(perform (op define-variable!) (const procedure-environment) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry455) (reg env))
(goto (label after-lambda454))
entry455
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (proc)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const primitive))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const proc) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch458))
compiled-branch457
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch458
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call456
after-lambda454
(perform (op define-variable!) (const primitive-procedure?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry450) (reg env))
(goto (label after-lambda449))
entry450
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
(assign val (const cond))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch453))
compiled-branch452
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch453
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call451
after-lambda449
(perform (op define-variable!) (const cond?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry445) (reg env))
(goto (label after-lambda444))
entry445
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch448))
compiled-branch447
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch448
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call446
after-lambda444
(perform (op define-variable!) (const cond-clauses) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry437) (reg env))
(goto (label after-lambda436))
entry437
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (clause)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const eq?) (reg env))
(save continue)
(save proc)
(assign val (const else))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const cond-predicate) (reg env))
(assign val (op lookup-variable-value) (const clause) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch440))
compiled-branch439
(assign continue (label after-call438))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch440
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call438
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch443))
compiled-branch442
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch443
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call441
after-lambda436
(perform (op define-variable!) (const cond-else-clause?) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry432) (reg env))
(goto (label after-lambda431))
entry432
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (clause)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const clause) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch435))
compiled-branch434
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch435
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call433
after-lambda431
(perform (op define-variable!) (const cond-predicate) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry427) (reg env))
(goto (label after-lambda426))
entry427
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (clause)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const clause) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch430))
compiled-branch429
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch430
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call428
after-lambda426
(perform (op define-variable!) (const cond-actions) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry419) (reg env))
(goto (label after-lambda418))
entry419
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const expand-clauses) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const cond-clauses) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch422))
compiled-branch421
(assign continue (label after-call420))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch422
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call420
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch425))
compiled-branch424
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch425
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call423
after-lambda418
(perform (op define-variable!) (const cond->if) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry364) (reg env))
(goto (label after-lambda363))
entry364
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (clauses)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const clauses) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch417))
compiled-branch416
(assign continue (label after-call415))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch417
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call415
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch366))
true-branch367
(assign val (const false))
(goto (reg continue))
false-branch366
(assign proc (op make-compiled-procedure) (label entry375) (reg env))
(goto (label after-lambda374))
entry375
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (first rest)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const cond-else-clause?) (reg env))
(assign val (op lookup-variable-value) (const first) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch411))
compiled-branch410
(assign continue (label after-call409))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch411
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call409
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch377))
true-branch378
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const rest) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch408))
compiled-branch407
(assign continue (label after-call406))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch408
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call406
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch395))
true-branch396
(assign proc (op lookup-variable-value) (const sequence->exp) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const cond-actions) (reg env))
(assign val (op lookup-variable-value) (const first) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch402))
compiled-branch401
(assign continue (label after-call400))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch402
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call400
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch405))
compiled-branch404
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch405
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call403
false-branch395
(assign proc (op lookup-variable-value) (const error) (reg env))
(assign val (op lookup-variable-value) (const clauses) (reg env))
(assign argl (op list) (reg val))
(assign val (const "ELSE clause isn't \n                            last: COND->IF"))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch399))
compiled-branch398
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch399
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call397
after-if394
false-branch377
(assign proc (op lookup-variable-value) (const make-if) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const expand-clauses) (reg env))
(assign val (op lookup-variable-value) (const rest) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch390))
compiled-branch389
(assign continue (label after-call388))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch390
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call388
(assign argl (op list) (reg val))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const sequence->exp) (reg env))
(save proc)
(assign proc (op lookup-variable-value) (const cond-actions) (reg env))
(assign val (op lookup-variable-value) (const first) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch384))
compiled-branch383
(assign continue (label after-call382))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch384
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call382
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch387))
compiled-branch386
(assign continue (label after-call385))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch387
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call385
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const cond-predicate) (reg env))
(assign val (op lookup-variable-value) (const first) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch381))
compiled-branch380
(assign continue (label after-call379))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch381
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call379
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch393))
compiled-branch392
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch393
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call391
after-if376
after-lambda374
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const clauses) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch373))
compiled-branch372
(assign continue (label after-call371))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch373
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call371
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const clauses) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch370))
compiled-branch369
(assign continue (label after-call368))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch370
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call368
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch414))
compiled-branch413
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch414
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call412
after-if365
after-lambda363
(perform (op define-variable!) (const expand-clauses) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry248) (reg env))
(goto (label after-lambda247))
entry248
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const self-evaluating?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch362))
compiled-branch361
(assign continue (label after-call360))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch362
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call360
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch250))
true-branch251
(assign val (op lookup-variable-value) (const exp) (reg env))
(goto (reg continue))
false-branch250
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const variable?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch359))
compiled-branch358
(assign continue (label after-call357))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch359
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call357
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch253))
true-branch254
(assign proc (op lookup-variable-value) (const lookup-variable-value) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch356))
compiled-branch355
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch356
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call354
false-branch253
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const quoted?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch353))
compiled-branch352
(assign continue (label after-call351))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch353
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call351
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch256))
true-branch257
(assign proc (op lookup-variable-value) (const text-of-quotation) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch350))
compiled-branch349
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch350
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call348
false-branch256
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const assignment?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch347))
compiled-branch346
(assign continue (label after-call345))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch347
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call345
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch259))
true-branch260
(assign proc (op lookup-variable-value) (const eval-assignment) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch344))
compiled-branch343
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch344
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call342
false-branch259
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const definition?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch341))
compiled-branch340
(assign continue (label after-call339))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch341
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call339
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch262))
true-branch263
(assign proc (op lookup-variable-value) (const eval-definition) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch338))
compiled-branch337
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch338
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call336
false-branch262
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const if?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch335))
compiled-branch334
(assign continue (label after-call333))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch335
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call333
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch265))
true-branch266
(assign proc (op lookup-variable-value) (const eval-if) (reg env))
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch332))
compiled-branch331
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch332
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call330
false-branch265
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const lambda?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch329))
compiled-branch328
(assign continue (label after-call327))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch329
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call327
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch268))
true-branch269
(assign proc (op lookup-variable-value) (const make-procedure) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const lambda-body) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch323))
compiled-branch322
(assign continue (label after-call321))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch323
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call321
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const lambda-parameters) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch320))
compiled-branch319
(assign continue (label after-call318))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch320
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call318
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch326))
compiled-branch325
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch326
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call324
false-branch268
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const begin?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch317))
compiled-branch316
(assign continue (label after-call315))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch317
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call315
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch271))
true-branch272
(assign proc (op lookup-variable-value) (const eval-sequence) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const begin-actions) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch311))
compiled-branch310
(assign continue (label after-call309))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch311
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call309
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch314))
compiled-branch313
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch314
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call312
false-branch271
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const cond?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch308))
compiled-branch307
(assign continue (label after-call306))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch308
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call306
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch274))
true-branch275
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const cond->if) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch302))
compiled-branch301
(assign continue (label after-call300))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch302
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call300
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch305))
compiled-branch304
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch305
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call303
false-branch274
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const application?) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch299))
compiled-branch298
(assign continue (label after-call297))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch299
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call297
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch277))
true-branch278
(assign proc (op lookup-variable-value) (const apply-core) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const list-of-values) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const operands) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch290))
compiled-branch289
(assign continue (label after-call288))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch290
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call288
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch293))
compiled-branch292
(assign continue (label after-call291))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch293
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call291
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const env) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const operator) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch284))
compiled-branch283
(assign continue (label after-call282))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch284
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call282
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch287))
compiled-branch286
(assign continue (label after-call285))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch287
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call285
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch296))
compiled-branch295
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch296
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call294
false-branch277
(assign proc (op lookup-variable-value) (const error) (reg env))
(assign val (op lookup-variable-value) (const exp) (reg env))
(assign argl (op list) (reg val))
(assign val (const "Unknown expression \n                    type: EVAL"))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch281))
compiled-branch280
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch281
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call279
after-if276
after-if273
after-if270
after-if267
after-if264
after-if261
after-if258
after-if255
after-if252
after-if249
after-lambda247
(perform (op define-variable!) (const eval-core) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry213) (reg env))
(goto (label after-lambda212))
entry213
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (procedure arguments)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const primitive-procedure?) (reg env))
(assign val (op lookup-variable-value) (const procedure) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch246))
compiled-branch245
(assign continue (label after-call244))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch246
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call244
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch215))
true-branch216
(assign proc (op lookup-variable-value) (const apply-primitive-procedure) (reg env))
(assign val (op lookup-variable-value) (const arguments) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const procedure) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch243))
compiled-branch242
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch243
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call241
false-branch215
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const compound-procedure?) (reg env))
(assign val (op lookup-variable-value) (const procedure) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch240))
compiled-branch239
(assign continue (label after-call238))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch240
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call238
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch218))
true-branch219
(assign proc (op lookup-variable-value) (const eval-sequence) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const extend-environment) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const procedure-environment) (reg env))
(assign val (op lookup-variable-value) (const procedure) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch231))
compiled-branch230
(assign continue (label after-call229))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch231
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call229
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const arguments) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(save argl)
(assign proc (op lookup-variable-value) (const procedure-parameters) (reg env))
(assign val (op lookup-variable-value) (const procedure) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch228))
compiled-branch227
(assign continue (label after-call226))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch228
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call226
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch234))
compiled-branch233
(assign continue (label after-call232))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch234
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call232
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const procedure-body) (reg env))
(assign val (op lookup-variable-value) (const procedure) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch225))
compiled-branch224
(assign continue (label after-call223))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch225
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call223
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch237))
compiled-branch236
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch237
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call235
false-branch218
(assign proc (op lookup-variable-value) (const error) (reg env))
(assign val (op lookup-variable-value) (const procedure) (reg env))
(assign argl (op list) (reg val))
(assign val (const "Unknown procedure \n                    type: APPLY"))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch222))
compiled-branch221
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch222
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call220
after-if217
after-if214
after-lambda212
(perform (op define-variable!) (const apply-core) (reg val) (reg env))
(assign val (const ok))
(save env)
(assign proc (op lookup-variable-value) (const list) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const /) (reg env))
(assign argl (op list) (reg val))
(assign val (const /))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch208))
compiled-branch207
(assign continue (label after-call206))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch208
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call206
(assign argl (op list) (reg val))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const *) (reg env))
(assign argl (op list) (reg val))
(assign val (const *))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch205))
compiled-branch204
(assign continue (label after-call203))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch205
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call203
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const -) (reg env))
(assign argl (op list) (reg val))
(assign val (const -))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch202))
compiled-branch201
(assign continue (label after-call200))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch202
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call200
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const +) (reg env))
(assign argl (op list) (reg val))
(assign val (const +))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch199))
compiled-branch198
(assign continue (label after-call197))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch199
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call197
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const <) (reg env))
(assign argl (op list) (reg val))
(assign val (const <))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch196))
compiled-branch195
(assign continue (label after-call194))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch196
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call194
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const >) (reg env))
(assign argl (op list) (reg val))
(assign val (const >))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch193))
compiled-branch192
(assign continue (label after-call191))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch193
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call191
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const =) (reg env))
(assign argl (op list) (reg val))
(assign val (const =))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch190))
compiled-branch189
(assign continue (label after-call188))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch190
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call188
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const null?) (reg env))
(assign argl (op list) (reg val))
(assign val (const null?))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch187))
compiled-branch186
(assign continue (label after-call185))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch187
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call185
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const cons) (reg env))
(assign argl (op list) (reg val))
(assign val (const cons))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch184))
compiled-branch183
(assign continue (label after-call182))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch184
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call182
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const cdr) (reg env))
(assign argl (op list) (reg val))
(assign val (const cdr))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch181))
compiled-branch180
(assign continue (label after-call179))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch181
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call179
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const list) (reg env))
(assign val (op lookup-variable-value) (const car) (reg env))
(assign argl (op list) (reg val))
(assign val (const car))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch178))
compiled-branch177
(assign continue (label after-call176))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch178
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call176
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch211))
compiled-branch210
(assign continue (label after-call209))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch211
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call209
(restore env)
(perform (op define-variable!) (const primitive-procedures) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry154) (reg env))
(goto (label after-lambda153))
entry154
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (proc items)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const null?) (reg env))
(assign val (op lookup-variable-value) (const items) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch175))
compiled-branch174
(assign continue (label after-call173))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch175
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call173
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch156))
true-branch157
(assign val (const ()))
(goto (reg continue))
false-branch156
(assign proc (op lookup-variable-value) (const cons) (reg env))
(save continue)
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const map) (reg env))
(save proc)
(save env)
(assign proc (op lookup-variable-value) (const cdr) (reg env))
(assign val (op lookup-variable-value) (const items) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch166))
compiled-branch165
(assign continue (label after-call164))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch166
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call164
(assign argl (op list) (reg val))
(restore env)
(assign val (op lookup-variable-value) (const proc) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch169))
compiled-branch168
(assign continue (label after-call167))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch169
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call167
(assign argl (op list) (reg val))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const proc) (reg env))
(save proc)
(assign proc (op lookup-variable-value) (const car) (reg env))
(assign val (op lookup-variable-value) (const items) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch160))
compiled-branch159
(assign continue (label after-call158))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch160
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call158
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch163))
compiled-branch162
(assign continue (label after-call161))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch163
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call161
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch172))
compiled-branch171
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch172
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call170
after-if155
after-lambda153
(perform (op define-variable!) (const map) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry149) (reg env))
(goto (label after-lambda148))
entry149
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const ()) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const map) (reg env))
(assign val (op lookup-variable-value) (const primitive-procedures) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const car) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch152))
compiled-branch151
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch152
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call150
after-lambda148
(perform (op define-variable!) (const primitive-procedure-names) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry144) (reg env))
(goto (label after-lambda143))
entry144
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (proc)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const proc) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch147))
compiled-branch146
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch147
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call145
after-lambda143
(perform (op define-variable!) (const primitive-implementation) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry131) (reg env))
(goto (label after-lambda130))
entry131
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const ()) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const map) (reg env))
(assign val (op lookup-variable-value) (const primitive-procedures) (reg env))
(assign argl (op list) (reg val))
(assign val (op make-compiled-procedure) (label entry133) (reg env))
(goto (label after-lambda132))
entry133
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (proc)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const list) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const cadr) (reg env))
(assign val (op lookup-variable-value) (const proc) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch136))
compiled-branch135
(assign continue (label after-call134))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch136
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call134
(assign argl (op list) (reg val))
(assign val (const primitive))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch139))
compiled-branch138
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch139
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call137
after-lambda132
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch142))
compiled-branch141
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch142
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call140
after-lambda130
(perform (op define-variable!) (const primitive-procedure-objects) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry123) (reg env))
(goto (label after-lambda122))
entry123
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (proc args)) (reg argl) (reg env))
(assign proc (op lookup-variable-value) (const apply-in-underlying-scheme) (reg env))
(save continue)
(save proc)
(assign val (op lookup-variable-value) (const args) (reg env))
(assign argl (op list) (reg val))
(save argl)
(assign proc (op lookup-variable-value) (const primitive-implementation) (reg env))
(assign val (op lookup-variable-value) (const proc) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch126))
compiled-branch125
(assign continue (label after-call124))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch126
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call124
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch129))
compiled-branch128
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch129
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call127
after-lambda122
(perform (op define-variable!) (const apply-primitive-procedure) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry101) (reg env))
(goto (label after-lambda100))
entry101
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const ()) (reg argl) (reg env))
(assign proc (op make-compiled-procedure) (label entry112) (reg env))
(goto (label after-lambda111))
entry112
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (initial-env)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const define-variable!) (reg env))
(assign val (op lookup-variable-value) (const initial-env) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const true) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (const true))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch118))
compiled-branch117
(assign continue (label after-call116))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch118
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call116
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const define-variable!) (reg env))
(assign val (op lookup-variable-value) (const initial-env) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const false) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(assign val (const false))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch115))
compiled-branch114
(assign continue (label after-call113))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch115
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call113
(restore env)
(restore continue)
(assign val (op lookup-variable-value) (const initial-env) (reg env))
(goto (reg continue))
after-lambda111
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const extend-environment) (reg env))
(save proc)
(assign val (op lookup-variable-value) (const the-empty-environment) (reg env))
(assign argl (op list) (reg val))
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const primitive-procedure-objects) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch107))
compiled-branch106
(assign continue (label after-call105))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch107
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call105
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const primitive-procedure-names) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch104))
compiled-branch103
(assign continue (label after-call102))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch104
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call102
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch110))
compiled-branch109
(assign continue (label after-call108))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch110
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call108
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch121))
compiled-branch120
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch121
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call119
after-lambda100
(perform (op define-variable!) (const setup-environment) (reg val) (reg env))
(assign val (const ok))
(save env)
(assign proc (op lookup-variable-value) (const setup-environment) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch99))
compiled-branch98
(assign continue (label after-call97))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch99
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call97
(restore env)
(perform (op define-variable!) (const the-global-environment) (reg val) (reg env))
(assign val (const ok))
(assign val (const "λ["))
(perform (op define-variable!) (const input-prompt) (reg val) (reg env))
(assign val (const ok))
(assign val (const "=>["))
(perform (op define-variable!) (const output-prompt) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry65) (reg env))
(goto (label after-lambda64))
entry65
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (in-count)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const prompt-for-input) (reg env))
(assign val (op lookup-variable-value) (const input-prompt) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const in-count) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch96))
compiled-branch95
(assign continue (label after-call94))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch96
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call94
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op make-compiled-procedure) (label entry76) (reg env))
(goto (label after-lambda75))
entry76
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (input)) (reg argl) (reg env))
(assign proc (op make-compiled-procedure) (label entry81) (reg env))
(goto (label after-lambda80))
entry81
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (output)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const announce-output) (reg env))
(assign val (op lookup-variable-value) (const output-prompt) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const in-count) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch87))
compiled-branch86
(assign continue (label after-call85))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch87
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call85
(restore env)
(restore continue)
(assign proc (op lookup-variable-value) (const user-print) (reg env))
(assign val (op lookup-variable-value) (const output) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch84))
compiled-branch83
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch84
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call82
after-lambda80
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const eval-core) (reg env))
(assign val (op lookup-variable-value) (const the-global-environment) (reg env))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const input) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch79))
compiled-branch78
(assign continue (label after-call77))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch79
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call77
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch90))
compiled-branch89
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch90
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call88
after-lambda75
(save proc)
(assign proc (op lookup-variable-value) (const read) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch74))
compiled-branch73
(assign continue (label after-call72))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch74
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call72
(assign argl (op list) (reg val))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch93))
compiled-branch92
(assign continue (label after-call91))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch93
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call91
(restore env)
(restore continue)
(assign proc (op lookup-variable-value) (const driver-loop) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const +) (reg env))
(assign val (const 1))
(assign argl (op list) (reg val))
(assign val (op lookup-variable-value) (const in-count) (reg env))
(assign argl (op cons) (reg val) (reg argl))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch68))
compiled-branch67
(assign continue (label after-call66))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch68
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call66
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch71))
compiled-branch70
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch71
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call69
after-lambda64
(perform (op define-variable!) (const driver-loop) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry45) (reg env))
(goto (label after-lambda44))
entry45
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (in-count string)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const newline) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch63))
compiled-branch62
(assign continue (label after-call61))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch63
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call61
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const newline) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch60))
compiled-branch59
(assign continue (label after-call58))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch60
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call58
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const display) (reg env))
(assign val (op lookup-variable-value) (const string) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch57))
compiled-branch56
(assign continue (label after-call55))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch57
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call55
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const display) (reg env))
(assign val (op lookup-variable-value) (const in-count) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch54))
compiled-branch53
(assign continue (label after-call52))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch54
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call52
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const display) (reg env))
(assign val (const "]: "))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch51))
compiled-branch50
(assign continue (label after-call49))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch51
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call49
(restore env)
(restore continue)
(assign proc (op lookup-variable-value) (const newline) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch48))
compiled-branch47
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch48
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call46
after-lambda44
(perform (op define-variable!) (const prompt-for-input) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry28) (reg env))
(goto (label after-lambda27))
entry28
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (out-count string)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const newline) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch43))
compiled-branch42
(assign continue (label after-call41))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch43
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call41
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const display) (reg env))
(assign val (op lookup-variable-value) (const string) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch40))
compiled-branch39
(assign continue (label after-call38))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch40
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call38
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const display) (reg env))
(assign val (op lookup-variable-value) (const out-count) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch37))
compiled-branch36
(assign continue (label after-call35))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch37
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call35
(restore env)
(restore continue)
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const display) (reg env))
(assign val (const "]: "))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch34))
compiled-branch33
(assign continue (label after-call32))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch34
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call32
(restore env)
(restore continue)
(assign proc (op lookup-variable-value) (const newline) (reg env))
(assign argl (const ()))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch31))
compiled-branch30
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch31
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call29
after-lambda27
(perform (op define-variable!) (const announce-output) (reg val) (reg env))
(assign val (const ok))
(assign val (op make-compiled-procedure) (label entry5) (reg env))
(goto (label after-lambda4))
entry5
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (object)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc (op lookup-variable-value) (const compound-procedure?) (reg env))
(assign val (op lookup-variable-value) (const object) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch26))
compiled-branch25
(assign continue (label after-call24))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch26
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call24
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch7))
true-branch8
(assign proc (op lookup-variable-value) (const display) (reg env))
(save continue)
(save proc)
(assign proc (op lookup-variable-value) (const list) (reg env))
(save proc)
(assign val (const <procedure-env>))
(assign argl (op list) (reg val))
(save env)
(save argl)
(assign proc (op lookup-variable-value) (const procedure-body) (reg env))
(assign val (op lookup-variable-value) (const object) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch17))
compiled-branch16
(assign continue (label after-call15))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch17
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call15
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(restore env)
(save argl)
(assign proc (op lookup-variable-value) (const procedure-parameters) (reg env))
(assign val (op lookup-variable-value) (const object) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch14))
compiled-branch13
(assign continue (label after-call12))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch14
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call12
(restore argl)
(assign argl (op cons) (reg val) (reg argl))
(assign val (const compound-procedure))
(assign argl (op cons) (reg val) (reg argl))
(restore proc)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch20))
compiled-branch19
(assign continue (label after-call18))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch20
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call18
(assign argl (op list) (reg val))
(restore proc)
(restore continue)
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch23))
compiled-branch22
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch23
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call21
false-branch7
(assign proc (op lookup-variable-value) (const display) (reg env))
(assign val (op lookup-variable-value) (const object) (reg env))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch11))
compiled-branch10
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch11
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
(goto (reg continue))
after-call9
after-if6
after-lambda4
(perform (op define-variable!) (const user-print) (reg val) (reg env))
(assign val (const ok))
(assign proc (op lookup-variable-value) (const driver-loop) (reg env))
(assign val (const 0))
(assign argl (op list) (reg val))
(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch3))
compiled-branch2
(assign continue (label after-call1))
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch3
(assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1
