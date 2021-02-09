;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{3,4}[ |\-]{0,1}[0-9]{6}[ |\-]{0,1}[0-9A-Za-z]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "frs|938758 x8v"
(define-fun Witness1 () String (seq.++ "f" (seq.++ "r" (seq.++ "s" (seq.++ "|" (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "7" (seq.++ "5" (seq.++ "8" (seq.++ " " (seq.++ "x" (seq.++ "8" (seq.++ "v" "")))))))))))))))
;witness2: "IAS108918|EEX"
(define-fun Witness2 () String (seq.++ "I" (seq.++ "A" (seq.++ "S" (seq.++ "1" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "8" (seq.++ "|" (seq.++ "E" (seq.++ "E" (seq.++ "X" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
