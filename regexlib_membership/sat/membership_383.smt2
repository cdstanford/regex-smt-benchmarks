;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^0-9]((\(?(\+420|00420)\)?( |-)?)?([0-9]{3} ?(([0-9]{3} ?[0-9]{3})|([0-9]{2} ?[0-9]{2} ?[0-9]{2})))|([0-9]{3}-(([0-9]{3}-[0-9]{3})|([0-9]{2}-[0-9]{2}-[0-9]{2}))))[^0-9|/]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "U(00420-86987 9265\x1C\u00F8\u00F2"
(define-fun Witness1 () String (str.++ "U" (str.++ "(" (str.++ "0" (str.++ "0" (str.++ "4" (str.++ "2" (str.++ "0" (str.++ "-" (str.++ "8" (str.++ "6" (str.++ "9" (str.++ "8" (str.++ "7" (str.++ " " (str.++ "9" (str.++ "2" (str.++ "6" (str.++ "5" (str.++ "\u{1c}" (str.++ "\u{f8}" (str.++ "\u{f2}" ""))))))))))))))))))))))
;witness2: "\u00D3\x9\x19\u00BA709 6410 06W"
(define-fun Witness2 () String (str.++ "\u{d3}" (str.++ "\u{09}" (str.++ "\u{19}" (str.++ "\u{ba}" (str.++ "7" (str.++ "0" (str.++ "9" (str.++ " " (str.++ "6" (str.++ "4" (str.++ "1" (str.++ "0" (str.++ " " (str.++ "0" (str.++ "6" (str.++ "W" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}"))(re.++ (re.union (re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ (re.union (str.to_re (str.++ "+" (str.++ "4" (str.++ "2" (str.++ "0" ""))))) (str.to_re (str.++ "0" (str.++ "0" (str.++ "4" (str.++ "2" (str.++ "0" "")))))))(re.++ (re.opt (re.range ")" ")")) (re.opt (re.union (re.range " " " ") (re.range "-" "-"))))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 3) (re.range "0" "9")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 2 2) (re.range "0" "9")))))))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 3 3) (re.range "0" "9")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))))))))) (re.union (re.range "\u{00}" ".")(re.union (re.range ":" "{") (re.range "}" "\u{ff}")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
