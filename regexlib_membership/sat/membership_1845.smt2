;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008Ahttp://O\u00E3z.\u00E9x.-"
(define-fun Witness1 () String (seq.++ "\x8a" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "O" (seq.++ "\xe3" (seq.++ "z" (seq.++ "." (seq.++ "\xe9" (seq.++ "x" (seq.++ "." (seq.++ "-" "")))))))))))))))))
;witness2: "\u00A8ftp://\u00C1.-"
(define-fun Witness2 () String (seq.++ "\xa8" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xc1" (seq.++ "." (seq.++ "-" "")))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" "")))) (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" ""))))))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.+ (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))) (re.opt (re.++ (re.* (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))) (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
