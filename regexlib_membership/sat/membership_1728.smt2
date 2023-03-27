;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{1}[a-z]{1,})$|^([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: "Ycekmehp Vac Jh"
(define-fun Witness2 () String (str.++ "Y" (str.++ "c" (str.++ "e" (str.++ "k" (str.++ "m" (str.++ "e" (str.++ "h" (str.++ "p" (str.++ " " (str.++ "V" (str.++ "a" (str.++ "c" (str.++ " " (str.++ "J" (str.++ "h" ""))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "A" "Z") (re.+ (re.range "a" "z"))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z"))))))))) (str.to_re ""))) (re.++ (str.to_re "") (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
