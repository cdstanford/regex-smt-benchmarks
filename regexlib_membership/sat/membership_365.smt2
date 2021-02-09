;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\w\d:#@%/;$()~_\+-=\\\.&]*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "jgopher:\\\x1By\x0\u00E7"
(define-fun Witness1 () String (seq.++ "j" (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\x1b" (seq.++ "y" (seq.++ "\x00" (seq.++ "\xe7" "")))))))))))))))
;witness2: "telnet:\\\u00DD,P)\u00B5\u00E3\u00F1\x1Fm9"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "\xdd" (seq.++ "," (seq.++ "P" (seq.++ ")" (seq.++ "\xb5" (seq.++ "\xe3" (seq.++ "\xf1" (seq.++ "\x1f" (seq.++ "m" (seq.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" ""))))) (re.opt (re.range "s" "s")))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" "")))))))(re.union (str.to_re (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" "")))))))(re.union (str.to_re (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" "")))))(re.union (str.to_re (seq.++ "n" (seq.++ "o" (seq.++ "t" (seq.++ "e" (seq.++ "s" "")))))) (str.to_re (seq.++ "m" (seq.++ "s" (seq.++ "-" (seq.++ "h" (seq.++ "e" (seq.++ "l" (seq.++ "p" ""))))))))))))))(re.++ (re.range ":" ":")(re.++ (re.+ (re.union (str.to_re (seq.++ "/" (seq.++ "/" ""))) (str.to_re (seq.++ "\x5c" (seq.++ "\x5c" ""))))) (re.* (re.union (re.range "#" "&")(re.union (re.range "(" ")")(re.union (re.range "+" "=")(re.union (re.range "@" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
