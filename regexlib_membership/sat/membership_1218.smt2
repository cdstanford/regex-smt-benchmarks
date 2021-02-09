;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\.\w&#230;&#248;&#229;-]+@([a-z&#230;&#248;&#229;0-9]+([\.-]{0,1}[a-z&#230;&#248;&#229;0-9]+|[a-z&#230;&#248;&#229;0-9]?))+\.[a-z]{2,6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C5@#&.lt"
(define-fun Witness1 () String (seq.++ "\xc5" (seq.++ "@" (seq.++ "#" (seq.++ "&" (seq.++ "." (seq.++ "l" (seq.++ "t" ""))))))))
;witness2: "T\u00B5@y1.ehk"
(define-fun Witness2 () String (seq.++ "T" (seq.++ "\xb5" (seq.++ "@" (seq.++ "y" (seq.++ "1" (seq.++ "." (seq.++ "e" (seq.++ "h" (seq.++ "k" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "&" "&")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "&" "&")(re.union (re.range "0" "9")(re.union (re.range ";" ";") (re.range "a" "z")))))) (re.union (re.++ (re.opt (re.range "-" ".")) (re.+ (re.union (re.range "#" "#")(re.union (re.range "&" "&")(re.union (re.range "0" "9")(re.union (re.range ";" ";") (re.range "a" "z"))))))) (re.opt (re.union (re.range "#" "#")(re.union (re.range "&" "&")(re.union (re.range "0" "9")(re.union (re.range ";" ";") (re.range "a" "z")))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 6) (re.range "a" "z")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
