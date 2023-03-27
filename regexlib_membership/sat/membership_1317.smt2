;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{3,4}[ |\-]{0,1}[0-9]{6}[ |\-]{0,1}[0-9A-Za-z]{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "frs|938758 x8v"
(define-fun Witness1 () String (str.++ "f" (str.++ "r" (str.++ "s" (str.++ "|" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "7" (str.++ "5" (str.++ "8" (str.++ " " (str.++ "x" (str.++ "8" (str.++ "v" "")))))))))))))))
;witness2: "IAS108918|EEX"
(define-fun Witness2 () String (str.++ "I" (str.++ "A" (str.++ "S" (str.++ "1" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "|" (str.++ "E" (str.++ "E" (str.++ "X" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
