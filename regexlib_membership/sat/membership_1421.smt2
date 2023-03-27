;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:(?:[\+]?(?<CountryCode>[\d]{1,3}(?:[ ]+|[\-.])))?[(]?(?<AreaCode>[\d]{3})[\-/)]?(?:[ ]+)?)?(?<Number>[a-zA-Z2-9][a-zA-Z0-9 \-.]{6,})(?:(?:[ ]+|[xX]|(i:ext[\.]?)){1,2}(?<Ext>[\d]{1,5}))?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "yzy-9HVy"
(define-fun Witness1 () String (str.++ "y" (str.++ "z" (str.++ "y" (str.++ "-" (str.++ "9" (str.++ "H" (str.++ "V" (str.++ "y" "")))))))))
;witness2: "18.(355VW8No o"
(define-fun Witness2 () String (str.++ "1" (str.++ "8" (str.++ "." (str.++ "(" (str.++ "3" (str.++ "5" (str.++ "5" (str.++ "V" (str.++ "W" (str.++ "8" (str.++ "N" (str.++ "o" (str.++ " " (str.++ "o" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.++ (re.opt (re.range "+" "+")) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.union (re.+ (re.range " " " ")) (re.range "-" ".")))))(re.++ (re.opt (re.range "(" "("))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range ")" ")")(re.union (re.range "-" "-") (re.range "/" "/")))) (re.* (re.range " " " ")))))))(re.++ (re.++ (re.union (re.range "2" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.++ ((_ re.loop 6 6) (re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.* (re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))(re.++ (re.opt (re.++ ((_ re.loop 1 2) (re.union (re.+ (re.range " " " "))(re.union (re.union (re.range "X" "X") (re.range "x" "x")) (re.++ (str.to_re (str.++ "i" (str.++ ":" (str.++ "e" (str.++ "x" (str.++ "t" "")))))) (re.opt (re.range "." ".")))))) ((_ re.loop 1 5) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
