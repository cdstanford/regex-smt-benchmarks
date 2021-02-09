;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|^\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6 Tajz Kko Go Pzq"
(define-fun Witness1 () String (seq.++ "6" (seq.++ " " (seq.++ "T" (seq.++ "a" (seq.++ "j" (seq.++ "z" (seq.++ " " (seq.++ "K" (seq.++ "k" (seq.++ "o" (seq.++ " " (seq.++ "G" (seq.++ "o" (seq.++ " " (seq.++ "P" (seq.++ "z" (seq.++ "q" ""))))))))))))))))))
;witness2: "88 Msam Zp"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ " " (seq.++ "M" (seq.++ "s" (seq.++ "a" (seq.++ "m" (seq.++ " " (seq.++ "Z" (seq.++ "p" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z"))))))))) (str.to_re ""))))) (re.++ (str.to_re "")(re.++ ((_ re.loop 1 6) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z"))(re.++ (re.range " " " ")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
