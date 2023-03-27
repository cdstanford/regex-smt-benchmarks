;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<user>(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\"(?:(?:[^\"\\\r\n])|(?:\\.))*\"))(?:\.(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\"(?:(?:[^\"\\\r\n])|(?:\\.))*\")))*)@(?<domain>(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\[(?:(?:[^\[\]\\\r\n])|(?:\\.))*\]))(?:\.(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\[(?:(?:[^\[\]\\\r\n])|(?:\\.))*\])))*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u008B}\u00A9\x1E\u00AEj\x14^@[]"
(define-fun Witness1 () String (str.++ "\u{8b}" (str.++ "}" (str.++ "\u{a9}" (str.++ "\u{1e}" (str.++ "\u{ae}" (str.++ "j" (str.++ "\u{14}" (str.++ "^" (str.++ "@" (str.++ "[" (str.++ "]" ""))))))))))))
;witness2: "\u00F8\u00E1\x8\u0089.\"\"@\u0098\x1D\u00D6.\u009E"
(define-fun Witness2 () String (str.++ "\u{f8}" (str.++ "\u{e1}" (str.++ "\u{08}" (str.++ "\u{89}" (str.++ "." (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "@" (str.++ "\u{98}" (str.++ "\u{1d}" (str.++ "\u{d6}" (str.++ "." (str.++ "\u{9e}" ""))))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\u{ff}"))))))))))))) (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "!")(re.union (re.range "#" "[") (re.range "]" "\u{ff}"))))) (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.range "\u{22}" "\u{22}")))) (re.* (re.++ (re.range "." ".") (re.union (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\u{ff}"))))))))))))) (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "!")(re.union (re.range "#" "[") (re.range "]" "\u{ff}"))))) (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.range "\u{22}" "\u{22}")))))))(re.++ (re.range "@" "@") (re.++ (re.union (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\u{ff}"))))))))))))) (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "Z") (re.range "^" "\u{ff}")))) (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.range "]" "]")))) (re.* (re.++ (re.range "." ".") (re.union (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\u{ff}"))))))))))))) (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "Z") (re.range "^" "\u{ff}")))) (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))) (re.range "]" "]")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
