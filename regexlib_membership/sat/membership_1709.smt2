;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <script[^>]*>[\w|\t|\r|\W]*</script>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "k<script|\x121>\u0080</script>\u00AB"
(define-fun Witness1 () String (seq.++ "k" (seq.++ "<" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ "|" (seq.++ "\x12" (seq.++ "1" (seq.++ ">" (seq.++ "\x80" (seq.++ "<" (seq.++ "/" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ ">" (seq.++ "\xab" ""))))))))))))))))))))))))
;witness2: "\u00A4<script\u00FA\u00CD?\u00EF>\u00E2\u009B</script>"
(define-fun Witness2 () String (seq.++ "\xa4" (seq.++ "<" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ "\xfa" (seq.++ "\xcd" (seq.++ "?" (seq.++ "\xef" (seq.++ ">" (seq.++ "\xe2" (seq.++ "\x9b" (seq.++ "<" (seq.++ "/" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ ">" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" ""))))))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.range ">" ">")(re.++ (re.* (re.range "\x00" "\xff")) (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ ">" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
