;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((\\\\([^\\/:\*\?"\|<>\. ]+))|([a-zA-Z]:\\))(([^\\/:\*\?"\|<>\. ]*)([\\]*))*)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Z:\\u00DE\u00AA\u00F2\x12"
(define-fun Witness1 () String (str.++ "Z" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{de}" (str.++ "\u{aa}" (str.++ "\u{f2}" (str.++ "\u{12}" ""))))))))
;witness2: "\\\u00C1"
(define-fun Witness2 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "\u{c1}" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (str.to_re (str.++ "\u{5c}" (str.++ "\u{5c}" ""))) (re.+ (re.union (re.range "\u{00}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}")))))))))))) (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re (str.++ ":" (str.++ "\u{5c}" ""))))) (re.* (re.++ (re.* (re.union (re.range "\u{00}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))) (re.* (re.range "\u{5c}" "\u{5c}"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
