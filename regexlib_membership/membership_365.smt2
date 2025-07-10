;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\w\d:#@%/;$()~_\+-=\\\.&]*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "jgopher:\\\x1By\x0\u00E7"
(define-fun Witness1 () String (str.++ "j" (str.++ "g" (str.++ "o" (str.++ "p" (str.++ "h" (str.++ "e" (str.++ "r" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "\u{1b}" (str.++ "y" (str.++ "\u{00}" (str.++ "\u{e7}" "")))))))))))))))
;witness2: "telnet:\\\u00DD,P)\u00B5\u00E3\u00F1\x1Fm9"
(define-fun Witness2 () String (str.++ "t" (str.++ "e" (str.++ "l" (str.++ "n" (str.++ "e" (str.++ "t" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "\u{dd}" (str.++ "," (str.++ "P" (str.++ ")" (str.++ "\u{b5}" (str.++ "\u{e3}" (str.++ "\u{f1}" (str.++ "\u{1f}" (str.++ "m" (str.++ "9" ""))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" ""))))) (re.opt (re.range "s" "s")))(re.union (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" ""))))(re.union (str.to_re (str.++ "g" (str.++ "o" (str.++ "p" (str.++ "h" (str.++ "e" (str.++ "r" "")))))))(re.union (str.to_re (str.++ "t" (str.++ "e" (str.++ "l" (str.++ "n" (str.++ "e" (str.++ "t" "")))))))(re.union (str.to_re (str.++ "f" (str.++ "i" (str.++ "l" (str.++ "e" "")))))(re.union (str.to_re (str.++ "n" (str.++ "o" (str.++ "t" (str.++ "e" (str.++ "s" "")))))) (str.to_re (str.++ "m" (str.++ "s" (str.++ "-" (str.++ "h" (str.++ "e" (str.++ "l" (str.++ "p" ""))))))))))))))(re.++ (re.range ":" ":")(re.++ (re.+ (re.union (str.to_re (str.++ "/" (str.++ "/" ""))) (str.to_re (str.++ "\u{5c}" (str.++ "\u{5c}" ""))))) (re.* (re.union (re.range "#" "&")(re.union (re.range "(" ")")(re.union (re.range "+" "=")(re.union (re.range "@" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
