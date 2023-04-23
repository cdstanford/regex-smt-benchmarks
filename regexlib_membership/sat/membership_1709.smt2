;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <script[^>]*>[\w|\t|\r|\W]*</script>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "k<script|\x121>\u0080</script>\u00AB"
(define-fun Witness1 () String (str.++ "k" (str.++ "<" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ "|" (str.++ "\u{12}" (str.++ "1" (str.++ ">" (str.++ "\u{80}" (str.++ "<" (str.++ "/" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ ">" (str.++ "\u{ab}" ""))))))))))))))))))))))))
;witness2: "\u00A4<script\u00FA\u00CD?\u00EF>\u00E2\u009B</script>"
(define-fun Witness2 () String (str.++ "\u{a4}" (str.++ "<" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ "\u{fa}" (str.++ "\u{cd}" (str.++ "?" (str.++ "\u{ef}" (str.++ ">" (str.++ "\u{e2}" (str.++ "\u{9b}" (str.++ "<" (str.++ "/" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ ">" "")))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" ""))))))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.range ">" ">")(re.++ (re.* (re.range "\u{00}" "\u{ff}")) (str.to_re (str.++ "<" (str.++ "/" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ ">" ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
