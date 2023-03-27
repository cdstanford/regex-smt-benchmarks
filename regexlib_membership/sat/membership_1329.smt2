;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z]{4}[ |\-]{0,1}[0-9]{6}[ |\-]{0,1}[0-9A-Za-z]{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "WBQB648663TGL"
(define-fun Witness1 () String (str.++ "W" (str.++ "B" (str.++ "Q" (str.++ "B" (str.++ "6" (str.++ "4" (str.++ "8" (str.++ "6" (str.++ "6" (str.++ "3" (str.++ "T" (str.++ "G" (str.++ "L" ""))))))))))))))
;witness2: "KREO|98082738o"
(define-fun Witness2 () String (str.++ "K" (str.++ "R" (str.++ "E" (str.++ "O" (str.++ "|" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "2" (str.++ "7" (str.++ "3" (str.++ "8" (str.++ "o" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "|" "|"))))(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
