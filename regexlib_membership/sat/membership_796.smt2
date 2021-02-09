;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \(?(\d{3})(?:\)*|\)\s*-*|\.*|\s*|/*|)(\d{3})(?:\)*|-*|\.*|\s*|/*|)(\d{4})(?:\s?|,\s?)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(2890895499\u0085*n"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "\x85" (seq.++ "*" (seq.++ "n" "")))))))))))))))
;witness2: "(138/0467832 \u00EB"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "1" (seq.++ "3" (seq.++ "8" (seq.++ "/" (seq.++ "0" (seq.++ "4" (seq.++ "6" (seq.++ "7" (seq.++ "8" (seq.++ "3" (seq.++ "2" (seq.++ " " (seq.++ "\xeb" "")))))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.range ")" ")"))(re.union (re.++ (re.range ")" ")")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.* (re.range "-" "-"))))(re.union (re.* (re.range "." "."))(re.union (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.union (re.* (re.range "/" "/")) (str.to_re ""))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.range ")" ")"))(re.union (re.* (re.range "-" "-"))(re.union (re.* (re.range "." "."))(re.union (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.union (re.* (re.range "/" "/")) (str.to_re ""))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.union (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.++ (re.range "," ",") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
