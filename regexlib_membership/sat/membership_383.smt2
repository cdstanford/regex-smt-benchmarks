;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^0-9]((\(?(\+420|00420)\)?( |-)?)?([0-9]{3} ?(([0-9]{3} ?[0-9]{3})|([0-9]{2} ?[0-9]{2} ?[0-9]{2})))|([0-9]{3}-(([0-9]{3}-[0-9]{3})|([0-9]{2}-[0-9]{2}-[0-9]{2}))))[^0-9|/]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "U(00420-86987 9265\x1C\u00F8\u00F2"
(define-fun Witness1 () String (seq.++ "U" (seq.++ "(" (seq.++ "0" (seq.++ "0" (seq.++ "4" (seq.++ "2" (seq.++ "0" (seq.++ "-" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "7" (seq.++ " " (seq.++ "9" (seq.++ "2" (seq.++ "6" (seq.++ "5" (seq.++ "\x1c" (seq.++ "\xf8" (seq.++ "\xf2" ""))))))))))))))))))))))
;witness2: "\u00D3\x9\x19\u00BA709 6410 06W"
(define-fun Witness2 () String (seq.++ "\xd3" (seq.++ "\x09" (seq.++ "\x19" (seq.++ "\xba" (seq.++ "7" (seq.++ "0" (seq.++ "9" (seq.++ " " (seq.++ "6" (seq.++ "4" (seq.++ "1" (seq.++ "0" (seq.++ " " (seq.++ "0" (seq.++ "6" (seq.++ "W" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (re.range "\x00" "/") (re.range ":" "\xff"))(re.++ (re.union (re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ (re.union (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "2" (seq.++ "0" ""))))) (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "4" (seq.++ "2" (seq.++ "0" "")))))))(re.++ (re.opt (re.range ")" ")")) (re.opt (re.union (re.range " " " ") (re.range "-" "-"))))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 3) (re.range "0" "9")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 2 2) (re.range "0" "9")))))))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 3 3) (re.range "0" "9")))) (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))))))))) (re.union (re.range "\x00" ".")(re.union (re.range ":" "{") (re.range "}" "\xff")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
