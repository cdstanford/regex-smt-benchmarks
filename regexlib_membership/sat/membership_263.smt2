;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^http://\w{0,3}.?youtube+\.\w{2,3}/watch\?v=[\w-]{11}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://youtube.8\u00F5/watch?v=8-\u00AAPG\u00E7\u00AAh8\u00AA\u00BA\u00D4"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "t" (seq.++ "u" (seq.++ "b" (seq.++ "e" (seq.++ "." (seq.++ "8" (seq.++ "\xf5" (seq.++ "/" (seq.++ "w" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "?" (seq.++ "v" (seq.++ "=" (seq.++ "8" (seq.++ "-" (seq.++ "\xaa" (seq.++ "P" (seq.++ "G" (seq.++ "\xe7" (seq.++ "\xaa" (seq.++ "h" (seq.++ "8" (seq.++ "\xaa" (seq.++ "\xba" (seq.++ "\xd4" "")))))))))))))))))))))))))))))))))))))))
;witness2: "http://i\u00E1youtubee.A6\u00AA/watch?v=-\u00AA\u00B5\u00BA\u00FB_iZ-9c"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "i" (seq.++ "\xe1" (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "t" (seq.++ "u" (seq.++ "b" (seq.++ "e" (seq.++ "e" (seq.++ "." (seq.++ "A" (seq.++ "6" (seq.++ "\xaa" (seq.++ "/" (seq.++ "w" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "?" (seq.++ "v" (seq.++ "=" (seq.++ "-" (seq.++ "\xaa" (seq.++ "\xb5" (seq.++ "\xba" (seq.++ "\xfb" (seq.++ "_" (seq.++ "i" (seq.++ "Z" (seq.++ "-" (seq.++ "9" (seq.++ "c" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ ((_ re.loop 0 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ "y" (seq.++ "o" (seq.++ "u" (seq.++ "t" (seq.++ "u" (seq.++ "b" "")))))))(re.++ (re.+ (re.range "e" "e"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (str.to_re (seq.++ "/" (seq.++ "w" (seq.++ "a" (seq.++ "t" (seq.++ "c" (seq.++ "h" (seq.++ "?" (seq.++ "v" (seq.++ "=" "")))))))))) ((_ re.loop 11 11) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
