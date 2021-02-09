;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = https?://[\w./]+\/[\w./]+\.(bmp|png|jpg|gif)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4http://\u00AA\u00BA\u00AA/Sz\u00DB\u00BA\u00AA\u00BA.gif\u0090a\xC"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xaa" (seq.++ "\xba" (seq.++ "\xaa" (seq.++ "/" (seq.++ "S" (seq.++ "z" (seq.++ "\xdb" (seq.++ "\xba" (seq.++ "\xaa" (seq.++ "\xba" (seq.++ "." (seq.++ "g" (seq.++ "i" (seq.++ "f" (seq.++ "\x90" (seq.++ "a" (seq.++ "\x0c" ""))))))))))))))))))))))))))
;witness2: "\u00B0https://j\u00B5./\u00B5.gifl"
(define-fun Witness2 () String (seq.++ "\xb0" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "j" (seq.++ "\xb5" (seq.++ "." (seq.++ "/" (seq.++ "\xb5" (seq.++ "." (seq.++ "g" (seq.++ "i" (seq.++ "f" (seq.++ "l" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.++ (re.opt (re.range "s" "s"))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.+ (re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "." ".") (re.union (str.to_re (seq.++ "b" (seq.++ "m" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "p" (seq.++ "n" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "g" "")))) (str.to_re (seq.++ "g" (seq.++ "i" (seq.++ "f" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
