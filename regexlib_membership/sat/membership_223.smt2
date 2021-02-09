;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z][a-zA-Z0-9_\.\-]+@([a-zA-Z0-9-]{2,}\.)+([a-zA-Z]{2,4}|[a-zA-Z]{2}\.[a-zA-Z]{2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Di@-1.8-9.rUN.xc.LO.xY.zZc"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "i" (seq.++ "@" (seq.++ "-" (seq.++ "1" (seq.++ "." (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "." (seq.++ "r" (seq.++ "U" (seq.++ "N" (seq.++ "." (seq.++ "x" (seq.++ "c" (seq.++ "." (seq.++ "L" (seq.++ "O" (seq.++ "." (seq.++ "x" (seq.++ "Y" (seq.++ "." (seq.++ "z" (seq.++ "Z" (seq.++ "c" "")))))))))))))))))))))))))))
;witness2: "L-@01o82e.bE.Rd"
(define-fun Witness2 () String (seq.++ "L" (seq.++ "-" (seq.++ "@" (seq.++ "0" (seq.++ "1" (seq.++ "o" (seq.++ "8" (seq.++ "2" (seq.++ "e" (seq.++ "." (seq.++ "b" (seq.++ "E" (seq.++ "." (seq.++ "R" (seq.++ "d" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "." ".")))(re.++ (re.union ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "." ".") ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
