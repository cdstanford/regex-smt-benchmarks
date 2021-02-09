;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z0-9_]{1}[a-z0-9\-_]*(\.[a-z0-9\-_]+)*@[a-z0-9]{1}[a-z0-9\-_]*(\.[a-z0-9\-_]+)*\.[a-z]{2,4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "_3._@0.tz"
(define-fun Witness1 () String (seq.++ "_" (seq.++ "3" (seq.++ "." (seq.++ "_" (seq.++ "@" (seq.++ "0" (seq.++ "." (seq.++ "t" (seq.++ "z" ""))))))))))
;witness2: "t_r._.8@8-.iyb"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "_" (seq.++ "r" (seq.++ "." (seq.++ "_" (seq.++ "." (seq.++ "8" (seq.++ "@" (seq.++ "8" (seq.++ "-" (seq.++ "." (seq.++ "i" (seq.++ "y" (seq.++ "b" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.range "a" "z")) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
