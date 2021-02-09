;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "i999.9@q.9.jvn"
(define-fun Witness1 () String (seq.++ "i" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "@" (seq.++ "q" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "j" (seq.++ "v" (seq.++ "n" "")))))))))))))))
;witness2: "9@8899m8.aNwr"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "@" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "m" (seq.++ "8" (seq.++ "." (seq.++ "a" (seq.++ "N" (seq.++ "w" (seq.++ "r" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.opt (re.range "-" ".")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range "." ".")(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
