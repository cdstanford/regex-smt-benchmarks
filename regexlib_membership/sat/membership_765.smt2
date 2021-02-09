;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [({]?(0x)?[0-9a-fA-F]{8}([-,]?(0x)?[0-9a-fA-F]{4}){2}((-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{12})|(,\{0x[0-9a-fA-F]{2}(,0x[0-9a-fA-F]{2}){7}\}))[)}]?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "B0xdAC8F09C43890x8F8c-9Aafa97941499aF5"
(define-fun Witness1 () String (seq.++ "B" (seq.++ "0" (seq.++ "x" (seq.++ "d" (seq.++ "A" (seq.++ "C" (seq.++ "8" (seq.++ "F" (seq.++ "0" (seq.++ "9" (seq.++ "C" (seq.++ "4" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "x" (seq.++ "8" (seq.++ "F" (seq.++ "8" (seq.++ "c" (seq.++ "-" (seq.++ "9" (seq.++ "A" (seq.++ "a" (seq.++ "f" (seq.++ "a" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "4" (seq.++ "1" (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "a" (seq.++ "F" (seq.++ "5" "")))))))))))))))))))))))))))))))))))))))
;witness2: "(9e98DA9B-04acC9998f9f-afb882bF96af"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "9" (seq.++ "e" (seq.++ "9" (seq.++ "8" (seq.++ "D" (seq.++ "A" (seq.++ "9" (seq.++ "B" (seq.++ "-" (seq.++ "0" (seq.++ "4" (seq.++ "a" (seq.++ "c" (seq.++ "C" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "f" (seq.++ "9" (seq.++ "f" (seq.++ "-" (seq.++ "a" (seq.++ "f" (seq.++ "b" (seq.++ "8" (seq.++ "8" (seq.++ "2" (seq.++ "b" (seq.++ "F" (seq.++ "9" (seq.++ "6" (seq.++ "a" (seq.++ "f" ""))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "(" "(") (re.range "{" "{")))(re.++ (re.opt (str.to_re (seq.++ "0" (seq.++ "x" ""))))(re.++ ((_ re.loop 8 8) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ ((_ re.loop 2 2) (re.++ (re.opt (re.range "," "-"))(re.++ (re.opt (str.to_re (seq.++ "0" (seq.++ "x" "")))) ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.++ (re.union (re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 12 12) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.++ (str.to_re (seq.++ "," (seq.++ "{" (seq.++ "0" (seq.++ "x" "")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ ((_ re.loop 7 7) (re.++ (str.to_re (seq.++ "," (seq.++ "0" (seq.++ "x" "")))) ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))) (re.range "}" "}"))))) (re.opt (re.union (re.range ")" ")") (re.range "}" "}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
