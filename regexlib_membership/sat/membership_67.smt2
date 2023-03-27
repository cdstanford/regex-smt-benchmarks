;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6 Tajz Kko Go Pzq"
(define-fun Witness1 () String (str.++ "6" (str.++ " " (str.++ "T" (str.++ "a" (str.++ "j" (str.++ "z" (str.++ " " (str.++ "K" (str.++ "k" (str.++ "o" (str.++ " " (str.++ "G" (str.++ "o" (str.++ " " (str.++ "P" (str.++ "z" (str.++ "q" ""))))))))))))))))))
;witness2: "88 Msam Zp"
(define-fun Witness2 () String (str.++ "8" (str.++ "8" (str.++ " " (str.++ "M" (str.++ "s" (str.++ "a" (str.++ "m" (str.++ " " (str.++ "Z" (str.++ "p" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z"))))))))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
