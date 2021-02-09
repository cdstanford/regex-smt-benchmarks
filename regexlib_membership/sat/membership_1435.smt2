;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[{|\(]?[0-9a-fA-F]{8}[-]?([0-9a-fA-F]{4}[-]?){3}[0-9a-fA-F]{12}[\)|}]?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6285C39A5C68A82d-baae0588fC8f4aBd|"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "2" (seq.++ "8" (seq.++ "5" (seq.++ "C" (seq.++ "3" (seq.++ "9" (seq.++ "A" (seq.++ "5" (seq.++ "C" (seq.++ "6" (seq.++ "8" (seq.++ "A" (seq.++ "8" (seq.++ "2" (seq.++ "d" (seq.++ "-" (seq.++ "b" (seq.++ "a" (seq.++ "a" (seq.++ "e" (seq.++ "0" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "f" (seq.++ "C" (seq.++ "8" (seq.++ "f" (seq.++ "4" (seq.++ "a" (seq.++ "B" (seq.++ "d" (seq.++ "|" "")))))))))))))))))))))))))))))))))))
;witness2: "997FFc88-3A8D-9a09-2091-A17078F6E838"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "F" (seq.++ "F" (seq.++ "c" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "3" (seq.++ "A" (seq.++ "8" (seq.++ "D" (seq.++ "-" (seq.++ "9" (seq.++ "a" (seq.++ "0" (seq.++ "9" (seq.++ "-" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "1" (seq.++ "-" (seq.++ "A" (seq.++ "1" (seq.++ "7" (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ "F" (seq.++ "6" (seq.++ "E" (seq.++ "8" (seq.++ "3" (seq.++ "8" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "(" "(") (re.range "{" "|")))(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.opt (re.range "-" "-"))))(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "|" "}"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
