;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <link href="../Common/Styles/iLienStyle.css" type="text/css" rel="stylesheet" />
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: " <link href=\"\u0089\x10/Common/Styles/iLienStyle\u00D2css\" type=\"text/css\" rel=\"stylesheet\" />"
(define-fun Witness1 () String (seq.++ " " (seq.++ "<" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "k" (seq.++ " " (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x89" (seq.++ "\x10" (seq.++ "/" (seq.++ "C" (seq.++ "o" (seq.++ "m" (seq.++ "m" (seq.++ "o" (seq.++ "n" (seq.++ "/" (seq.++ "S" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "i" (seq.++ "L" (seq.++ "i" (seq.++ "e" (seq.++ "n" (seq.++ "S" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "\xd2" (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "\x22" (seq.++ " " (seq.++ "t" (seq.++ "y" (seq.++ "p" (seq.++ "e" (seq.++ "=" (seq.++ "\x22" (seq.++ "t" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "/" (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "\x22" (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" (seq.++ "s" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "h" (seq.++ "e" (seq.++ "e" (seq.++ "t" (seq.++ "\x22" (seq.++ " " (seq.++ "/" (seq.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "<link href=\"(\u00A4/Common/Styles/iLienStyle+css\" type=\"text/css\" rel=\"stylesheet\" />"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "k" (seq.++ " " (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "\x22" (seq.++ "(" (seq.++ "\xa4" (seq.++ "/" (seq.++ "C" (seq.++ "o" (seq.++ "m" (seq.++ "m" (seq.++ "o" (seq.++ "n" (seq.++ "/" (seq.++ "S" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "i" (seq.++ "L" (seq.++ "i" (seq.++ "e" (seq.++ "n" (seq.++ "S" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "+" (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "\x22" (seq.++ " " (seq.++ "t" (seq.++ "y" (seq.++ "p" (seq.++ "e" (seq.++ "=" (seq.++ "\x22" (seq.++ "t" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "/" (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "\x22" (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" (seq.++ "s" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "h" (seq.++ "e" (seq.++ "e" (seq.++ "t" (seq.++ "\x22" (seq.++ " " (seq.++ "/" (seq.++ ">" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "l" (seq.++ "i" (seq.++ "n" (seq.++ "k" (seq.++ " " (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "\x22" "")))))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "/" (seq.++ "C" (seq.++ "o" (seq.++ "m" (seq.++ "m" (seq.++ "o" (seq.++ "n" (seq.++ "/" (seq.++ "S" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "/" (seq.++ "i" (seq.++ "L" (seq.++ "i" (seq.++ "e" (seq.++ "n" (seq.++ "S" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" ""))))))))))))))))))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "\x22" (seq.++ " " (seq.++ "t" (seq.++ "y" (seq.++ "p" (seq.++ "e" (seq.++ "=" (seq.++ "\x22" (seq.++ "t" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "/" (seq.++ "c" (seq.++ "s" (seq.++ "s" (seq.++ "\x22" (seq.++ " " (seq.++ "r" (seq.++ "e" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" (seq.++ "s" (seq.++ "t" (seq.++ "y" (seq.++ "l" (seq.++ "e" (seq.++ "s" (seq.++ "h" (seq.++ "e" (seq.++ "e" (seq.++ "t" (seq.++ "\x22" (seq.++ " " (seq.++ "/" (seq.++ ">" ""))))))))))))))))))))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
