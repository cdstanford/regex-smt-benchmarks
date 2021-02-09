;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B5y\u00AA@[10.92.94.9"
(define-fun Witness1 () String (seq.++ "\xb5" (seq.++ "y" (seq.++ "\xaa" (seq.++ "@" (seq.++ "[" (seq.++ "1" (seq.++ "0" (seq.++ "." (seq.++ "9" (seq.++ "2" (seq.++ "." (seq.++ "9" (seq.++ "4" (seq.++ "." (seq.++ "9" ""))))))))))))))))
;witness2: "\u00E2@[9.1.9.69]"
(define-fun Witness2 () String (seq.++ "\xe2" (seq.++ "@" (seq.++ "[" (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "." (seq.++ "9" (seq.++ "." (seq.++ "6" (seq.++ "9" (seq.++ "]" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.range "[" "[")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." "."))))))) (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.range "." "."))))(re.++ (re.union ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 1 3) (re.range "0" "9")))(re.++ (re.opt (re.range "]" "]")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
