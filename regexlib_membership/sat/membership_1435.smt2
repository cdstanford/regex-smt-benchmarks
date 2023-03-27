;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[{|\(]?[0-9a-fA-F]{8}[-]?([0-9a-fA-F]{4}[-]?){3}[0-9a-fA-F]{12}[\)|}]?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6285C39A5C68A82d-baae0588fC8f4aBd|"
(define-fun Witness1 () String (str.++ "6" (str.++ "2" (str.++ "8" (str.++ "5" (str.++ "C" (str.++ "3" (str.++ "9" (str.++ "A" (str.++ "5" (str.++ "C" (str.++ "6" (str.++ "8" (str.++ "A" (str.++ "8" (str.++ "2" (str.++ "d" (str.++ "-" (str.++ "b" (str.++ "a" (str.++ "a" (str.++ "e" (str.++ "0" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "f" (str.++ "C" (str.++ "8" (str.++ "f" (str.++ "4" (str.++ "a" (str.++ "B" (str.++ "d" (str.++ "|" "")))))))))))))))))))))))))))))))))))
;witness2: "997FFc88-3A8D-9a09-2091-A17078F6E838"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "F" (str.++ "F" (str.++ "c" (str.++ "8" (str.++ "8" (str.++ "-" (str.++ "3" (str.++ "A" (str.++ "8" (str.++ "D" (str.++ "-" (str.++ "9" (str.++ "a" (str.++ "0" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "0" (str.++ "9" (str.++ "1" (str.++ "-" (str.++ "A" (str.++ "1" (str.++ "7" (str.++ "0" (str.++ "7" (str.++ "8" (str.++ "F" (str.++ "6" (str.++ "E" (str.++ "8" (str.++ "3" (str.++ "8" "")))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "(" "(") (re.range "{" "|")))(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.opt (re.range "-" "-"))))(re.++ ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.union (re.range ")" ")") (re.range "|" "}"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
